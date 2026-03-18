export default function Home() {
  return (
    <div className="space-y-6">
      <div className="bg-white rounded-lg shadow p-6">
        <h1 className="text-4xl font-bold text-gray-900 mb-2">
          Welcome to Customer Support AI
        </h1>
        <p className="text-gray-600 text-lg">
          Manage your customer relationships, orders, and support tickets with AI-powered automation.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {[
          {
            title: 'Customers',
            description: 'Manage customer information and relationships',
            href: '/customers',
            color: 'bg-blue-50 border-blue-200',
          },
          {
            title: 'Orders',
            description: 'Track and manage customer orders',
            href: '/orders',
            color: 'bg-green-50 border-green-200',
          },
          {
            title: 'Support Tickets',
            description: 'Handle customer support cases and issues',
            href: '/cases',
            color: 'bg-purple-50 border-purple-200',
          },
          {
            title: 'Products',
            description: 'Manage merchandise and inventory',
            href: '/merchandise',
            color: 'bg-orange-50 border-orange-200',
          },
          {
            title: 'Knowledge Base',
            description: 'Browse and manage knowledge articles',
            href: '/knowledge',
            color: 'bg-pink-50 border-pink-200',
          },
          {
            title: 'Inspections',
            description: 'Track quality inspections and reports',
            href: '/inspections',
            color: 'bg-indigo-50 border-indigo-200',
          },
        ].map((module) => (
          <a
            key={module.href}
            href={module.href}
            className={`border-2 rounded-lg p-6 transition hover:shadow-lg ${module.color}`}
          >
            <h3 className="text-xl font-semibold mb-2">{module.title}</h3>
            <p className="text-gray-600">{module.description}</p>
          </a>
        ))}
      </div>
    </div>
  )
}
