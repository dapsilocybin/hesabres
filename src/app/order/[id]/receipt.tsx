'use client'

import Image from 'next/image'
import Link from 'next/link'

const mockOrder = {
  itemName: 'Custom Ceramic Mug',
  itemImage: '/mock-item.jpg',
  customerName: 'Ali Rezaei',
  orderId: 'ORD-8349'
}

export default function OrderReceiptPage() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center px-4 text-center">
      <div className="max-w-sm w-full border border-gray-200 shadow-md p-6 rounded-2xl">
        <div className="text-green-600 text-2xl font-semibold mb-4">Order Confirmed!</div>

        <div className="relative w-full h-48 mb-4 rounded-xl overflow-hidden border">
          <Image
            src={mockOrder.itemImage}
            alt={mockOrder.itemName}
            fill
            className="object-cover"
          />
        </div>

        <div className="text-lg font-medium mb-1">{mockOrder.itemName}</div>
        <div className="text-sm text-gray-600 mb-4">for <strong>{mockOrder.customerName}</strong></div>

        <div className="bg-gray-100 text-gray-700 text-sm py-2 px-4 rounded-md mb-6">
          Order ID: <code className="font-mono">{mockOrder.orderId}</code>
        </div>

        <Link
          href="/"
          className="inline-block w-full bg-orange-500 hover:bg-orange-600 text-white font-semibold py-2 px-4 rounded-xl transition"
        >
          Go to Homepage
        </Link>
      </div>
    </div>
  )
}
