import { storage } from './storageService';

export interface RazorpayPaymentOptions {
  planId: 'monthly' | 'annual';
  amountInr: number;
  userName: string;
  userEmail: string;
  onSuccess: (paymentId: string) => void;
  onFailure: (errorMsg: string) => void;
}

export class RazorpayService {
  private static KEY_ID = (import.meta as unknown as { env: { VITE_RAZORPAY_KEY_ID?: string } }).env.VITE_RAZORPAY_KEY_ID || 'rzp_test_NetAceDemoSandboxKey';

  public static isLiveConfigured(): boolean {
    const key = (import.meta as unknown as { env: { VITE_RAZORPAY_KEY_ID?: string } }).env.VITE_RAZORPAY_KEY_ID;
    return !!key && key.startsWith('rzp_live_');
  }

  public static openCheckout(options: RazorpayPaymentOptions): void {
    const isLive = this.isLiveConfigured();

    if (!isLive) {
      // Sandbox Test Mode Flow with interactive confirmation
      const confirmed = window.confirm(
        `[NetAce Razorpay Sandbox / Test Mode]\n\n` +
        `Plan: ${options.planId.toUpperCase()} (₹${options.amountInr})\n` +
        `Candidate: ${options.userName} (${options.userEmail})\n\n` +
        `Click OK to simulate successful Razorpay payment verification and unlock all Premium features instantly.\n` +
        `Click Cancel to simulate a declined payment.`
      );

      if (confirmed) {
        const simulatedPaymentId = 'pay_sandbox_' + Date.now();
        const simulatedOrderId = 'order_sandbox_' + Math.random().toString(36).substring(2, 9);
        
        // Server verification simulation
        this.applySubscription(options.planId, simulatedPaymentId);
        storage.addAuditLog('PAYMENT_SUCCESS', `Razorpay test order ${simulatedOrderId} verified. Paid ₹${options.amountInr}`);
        options.onSuccess(simulatedPaymentId);
      } else {
        storage.addAuditLog('PAYMENT_FAILED', `Razorpay test checkout cancelled or declined by user.`);
        options.onFailure('Payment checkout was cancelled or declined.');
      }
      return;
    }

    // Live Razorpay standard checkout
    const script = document.createElement('script');
    script.src = 'https://checkout.razorpay.com/v1/checkout.js';
    script.onload = () => {
      const RazorpayWindow = (window as unknown as { Razorpay: new (opts: unknown) => { open: () => void } }).Razorpay;
      if (!RazorpayWindow) {
        options.onFailure('Unable to load Razorpay SDK.');
        return;
      }

      const rzpOptions = {
        key: this.KEY_ID,
        amount: options.amountInr * 100, // paisa
        currency: 'INR',
        name: 'NetAce Learning',
        description: `${options.planId.toUpperCase()} Premium Access`,
        image: '/favicon.svg',
        prefill: {
          name: options.userName,
          email: options.userEmail
        },
        theme: {
          color: '#4F46E5'
        },
        handler: (response: { razorpay_payment_id: string; razorpay_order_id?: string; razorpay_signature?: string }) => {
          RazorpayService.applySubscription(options.planId, response.razorpay_payment_id);
          options.onSuccess(response.razorpay_payment_id);
        }
      };

      const instance = new RazorpayWindow(rzpOptions);
      instance.open();
    };
    script.onerror = () => options.onFailure('Network error loading Razorpay gateway.');
    document.body.appendChild(script);
  }

  private static applySubscription(planId: 'monthly' | 'annual', paymentId: string): void {
    const user = storage.getUser();
    user.isPremium = true;
    user.role = 'premium_student';
    user.planId = planId;
    
    // Set expiry
    const expiry = new Date();
    if (planId === 'annual') {
      expiry.setFullYear(expiry.getFullYear() + 1);
    } else {
      expiry.setMonth(expiry.getMonth() + 1);
    }
    user.premiumExpiresAt = expiry.toISOString();
    storage.saveUser(user);

    storage.awardXp(150, `Subscribed to NetAce Premium (${planId})`, 'achievement');
  }
}
