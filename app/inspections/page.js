'use client';

import { useEffect, useState } from 'react';

export default function InspectionsPage() {
  const [inspections, setInspections] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchInspections();
  }, []);

  async function fetchInspections() {
    try {
      const res = await fetch('/api/inspections');
      const data = await res.json();
      setInspections(data);
    } catch (error) {
      console.error('Error fetching inspections:', error);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="text-center py-12">Loading...</div>;

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold">Inspections</h1>

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <table className="w-full">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-sm font-semibold">Inspection ID</th>
              <th className="px-6 py-3 text-left text-sm font-semibold">Order</th>
              <th className="px-6 py-3 text-left text-sm font-semibold">Quality Score</th>
              <th className="px-6 py-3 text-left text-sm font-semibold">Status</th>
              <th className="px-6 py-3 text-left text-sm font-semibold">Date</th>
            </tr>
          </thead>
          <tbody>
            {inspections.map((inspection) => (
              <tr key={inspection._id} className="border-t hover:bg-gray-50">
                <td className="px-6 py-4">{inspection._id.slice(-8).toUpperCase()}</td>
                <td className="px-6 py-4">{inspection.orderId?._id?.slice(-8) || 'N/A'}</td>
                <td className="px-6 py-4">
                  <div className="w-full bg-gray-200 rounded-full h-2 max-w-xs">
                    <div
                      className="bg-green-600 h-2 rounded-full"
                      style={{ width: `${inspection.qualityScore || 0}%` }}
                    />
                  </div>
                  <span className="text-sm font-semibold">{inspection.qualityScore || 0}%</span>
                </td>
                <td className="px-6 py-4">
                  <span className={`px-3 py-1 rounded text-sm ${
                    inspection.status === 'Passed' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'
                  }`}>
                    {inspection.status}
                  </span>
                </td>
                <td className="px-6 py-4">{new Date(inspection.createdAt).toLocaleDateString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
