import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

export function WelcomeCard() {
  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="text-2xl font-bold">Welcome to Your Cursor Project</CardTitle>
          <Badge variant="secondary">v1.0.0</Badge>
        </div>
        <CardDescription className="text-base">
          A complete starter template with Next.js, shadcn/ui, and knowledge capture system
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="space-y-3">
          <h3 className="font-semibold text-lg">Quick Actions</h3>
          <div className="flex flex-wrap gap-2">
            <Button variant="default" size="sm">
              Get Started
            </Button>
            <Button variant="outline" size="sm">
              View Docs
            </Button>
            <Button variant="ghost" size="sm">
              Explore Components
            </Button>
          </div>
        </div>
        
        <div className="space-y-2 text-sm text-muted-foreground">
          <div className="flex items-center gap-2">
            <span className="text-green-500">✨</span>
            <span>Start coding with Cursor AI</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-blue-500">📚</span>
            <span>Document insights as you develop</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-purple-500">🎨</span>
            <span>Build beautiful UIs with shadcn/ui</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-orange-500">⚡</span>
            <span>Optimized with Next.js and Tailwind CSS</span>
          </div>
        </div>

        <div className="pt-4 border-t">
          <h4 className="font-medium mb-2">Next Steps:</h4>
          <ol className="list-decimal list-inside space-y-1 text-sm text-muted-foreground">
            <li>Run <code className="bg-muted px-1 rounded">npm run dev</code> to start development</li>
            <li>Use <code className="bg-muted px-1 rounded">./scripts/new-session.sh</code> to start a coding session</li>
            <li>Add more shadcn/ui components as needed</li>
            <li>Customize the theme and components</li>
          </ol>
        </div>
      </CardContent>
    </Card>
  );
} 