require 'rails_helper'

RSpec.describe 'Customers API', type: :request do
	#initialize test data
	let!(:customers) { create_customers(:customer, 10)}
	let(:customer_id) { customer.first.id }

	# Test suite for GET /customers
	describe 'GET /customers' do
		# make HTTP get request before each example
		before { get '/customers' }

		it 'returns customers' do
			# Note 'json' is a custom helper to parse JSON responses
			expect(json).not_to be_empty
			expect(json.size).to eq(10)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	# Test suite for GET /customers/:id
	describe 'GET /customers/:id' do
		before { get "/customers/#{customer_id}" }

		context 'when the record exists' do
			it 'returns the customer' do
				expect(json).not_to be_empty
				expect(json['id']).to eq(customer_id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:customer_id) { 100 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(response.body).to match(/Couldn't find Customer/)
			end
		end
	end

	# Test suite for POST /customers
	describe 'POST /customers' do
		# valid payload
		let(:valid_attributes) { { name: "Merry Jane", address: "123 Merry Lane Chicago, IL", major_intersection: "Dun & Bradstreet", phone_number: "1234567890" } }
		context 'when the request is valid' do 
			before { post '/customers', params: valid_attributes }

			it 'creates a customer' do 
				expect(json['name']).to eq('Merry Jane')
			end

			it 'returns status code 201' do 
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do 
			before { post '/customers', params: { name: 'Foobar' } }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(response.body).to match(/Validation failed: Created by can't be blank/)
			end
		end
	end

	# Test suite for PUT /customers/:id
	describe 'PUT /customers/:id' do
		let(:valid_attributes) { { name: 'Ms. Jane' } }

		context 'when the record exists' do
			before { put "/customers/#{customer_id}", params: valid_attributes }

			it 'updates the record' do
				expect(response.body).to be_empty
			end

			it 'returns status code 204' do
				expect(response).to have_http_status(204)
			end
		end
	end

	# Test suite for DELETE /customers/:id
	describe 'DELETE /customers/:id' do
		before { delete "/customers/#{customer_id}" }

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end