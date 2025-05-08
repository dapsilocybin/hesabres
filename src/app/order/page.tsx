import FlipCard from '@/components/FlipCard';
import OrderForm from '@/components/OrderForm';
import Image from 'next/image';

const dummyItem = {
  id: 'abc123',
  title: 'Wireless Camera',
  description: 'HD camera with night vision',
  image: '/images/camera.jpg',
  price: 120,
};

export default function OrderPage() {
  const Front = (
    <div className="p-6 bg-white rounded-xl shadow-lg h-full flex flex-col items-center justify-center">
      <div className="relative w-full h-48 mb-4">
        <Image
          src={dummyItem.image}
          alt={dummyItem.title}
          fill
          className="object-cover rounded-xl"
        />
      </div>
      <h1 className="text-2xl font-bold">{dummyItem.title}</h1>
      <p className="text-gray-600 text-sm mt-2">{dummyItem.description}</p>
      <p className="text-lg font-semibold text-orange-600 mt-4">
        ${dummyItem.price}
      </p>
    </div>
  );

  const Back = <OrderForm itemTitle={dummyItem.title} />;

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4 py-12">
      <FlipCard front={Front} back={Back} />
    </div>
  );
}
