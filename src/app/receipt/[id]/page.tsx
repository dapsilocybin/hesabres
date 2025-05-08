"use client";

import { mockItems } from "@/app/mockData";
import { useParams, useRouter } from "next/navigation";

export default function ReceiptPage() {
  const { id } = useParams();
  const router = useRouter();
  const item = mockItems[id as string];

  if (!item) return <div className="p-4">Item not found</div>;

  return (
    <div className="p-6 max-w-xl mx-auto space-y-6 text-center">
      <h1 className="text-2xl font-bold text-green-600">Order Placed!</h1>
      <p className="text-gray-700">Your order for:</p>
      <div className="bg-white shadow rounded-xl p-4 space-y-4">
        <img
          src={item.image}
          alt={item.title}
          className="w-full h-48 object-cover rounded-xl"
        />
        <h2 className="text-xl font-semibold">{item.title}</h2>
        <p className="text-gray-500">{item.description}</p>
        <p className="text-lg font-bold">${item.price}</p>
      </div>

      <button
        onClick={() => router.push("/")}
        className="mt-6 px-6 py-3 bg-orange-500 text-white rounded-2xl hover:bg-orange-600"
      >
        Back to Home
      </button>
    </div>
  );
}
