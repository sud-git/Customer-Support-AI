'use client';

import { useEffect, useState } from 'react';

export default function KnowledgePage() {
  const [articles, setArticles] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchArticles();
  }, []);

  async function fetchArticles() {
    try {
      const res = await fetch('/api/knowledge');
      const data = await res.json();
      setArticles(data);
    } catch (error) {
      console.error('Error fetching articles:', error);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="text-center py-12">Loading...</div>;

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold">Knowledge Base</h1>

      <div className="space-y-4">
        {articles.map((article) => (
          <div key={article._id} className="bg-white rounded-lg shadow p-6">
            <h3 className="text-xl font-semibold mb-2">{article.title}</h3>
            <p className="text-gray-600 mb-4 line-clamp-2">{article.content}</p>
            <div className="flex justify-between items-center">
              <div className="space-x-2">
                <span className="inline-block bg-blue-100 text-blue-800 px-3 py-1 rounded text-sm">
                  {article.topic}
                </span>
              </div>
              <p className="text-sm text-gray-500">
                Views: {article.views} | Helpful: {article.helpful}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
