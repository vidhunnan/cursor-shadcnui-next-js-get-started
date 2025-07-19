import { WelcomeCard } from "@/components/custom/welcome-card";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-4 sm:p-8 lg:p-24">
      <div className="z-10 w-full max-w-5xl items-center justify-between font-mono text-sm">
        <WelcomeCard />
      </div>
    </main>
  );
} 