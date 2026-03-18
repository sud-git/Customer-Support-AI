import './globals.css'

export const metadata = {
  title: 'Customer Support AI',
  description: 'AI-Powered Customer Support & Service Automation System',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="bg-gray-50">
        <nav className="bg-white shadow">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex justify-between h-16">
              <div className="flex items-center">
                <h1 className="text-2xl font-bold text-blue-600">Support AI</h1>
              </div>
              <div className="flex items-center space-x-4">
                <a href="/dashboard" className="text-gray-600 hover:text-gray-900">Dashboard</a>
                <a href="/customers" className="text-gray-600 hover:text-gray-900">Customers</a>
                <a href="/orders" className="text-gray-600 hover:text-gray-900">Orders</a>
                <a href="/cases" className="text-gray-600 hover:text-gray-900">Cases</a>
              </div>
            </div>
          </div>
        </nav>
        <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
          {children}
        </main>
      </body>
    </html>
  )
}
