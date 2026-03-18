import dbConnect from '@/lib/db';
import Customer from '@/models/Customer';
import Order from '@/models/Order';
import Case from '@/models/Case';
import Merchandise from '@/models/Merchandise';

export default async function Dashboard() {
  await dbConnect();

  try {
    const [customerCount, orderCount, caseCount, productCount] = await Promise.all([
      Customer.countDocuments(),
      Order.countDocuments(),
      Case.countDocuments(),
      Merchandise.countDocuments(),
    ]);

    const stats = [
      { label: 'Total Customers', value: customerCount, color: 'bg-blue-100', textColor: 'text-blue-700' },
      { label: 'Total Orders', value: orderCount, color: 'bg-green-100', textColor: 'text-green-700' },
      { label: 'Support Cases', value: caseCount, color: 'bg-purple-100', textColor: 'text-purple-700' },
      { label: 'Products', value: productCount, color: 'bg-orange-100', textColor: 'text-orange-700' },
    ];

    return (
      <div className="space-y-6">
        <h1 className="text-3xl font-bold">Dashboard</h1>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {stats.map((stat) => (
            <div key={stat.label} className={`${stat.color} rounded-lg p-6`}>
              <p className="text-gray-600 text-sm font-medium">{stat.label}</p>
              <p className={`${stat.textColor} text-3xl font-bold mt-2`}>{stat.value}</p>
            </div>
          ))}
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-xl font-semibold mb-4">Quick Links</h2>
          <ul className="space-y-2">
            <li><a href="/customers" className="text-blue-600 hover:underline">→ View all customers</a></li>
            <li><a href="/orders" className="text-blue-600 hover:underline">→ View all orders</a></li>
            <li><a href="/cases" className="text-blue-600 hover:underline">→ View all support cases</a></li>
            <li><a href="/merchandise" className="text-blue-600 hover:underline">→ View all products</a></li>
          </ul>
        </div>
      </div>
    );
  } catch (error) {
    return (
      <div className="text-red-600">
        Error loading dashboard: {error.message}
      </div>
    );
  }
}
