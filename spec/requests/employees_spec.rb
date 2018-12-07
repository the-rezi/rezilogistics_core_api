require 'rails_helper'

RSpec.describe 'Employees API', type: :request do
	#initialize test data
	let!(:employees) { create_list(:employees, 10)}
	let(:employee_id) { employee.first.id }

	# Test suite for GET /employees
	describe 'GET /employees' do
		# make HTTP get request before each example
		before { get '/employees' }

		it 'returns employees' do
			# Note 'json' is a custom helper to parse JSON responses
			expect(json).not_to be_empty
			expect(json.size).to eq(10)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	# Test suite for GET /employees/:id
	describe 'GET /employees/:id' do
		before { get "/employees/#{employee_id}" }

		context 'when the record exists' do
			it 'returns the employee' do
				expect(json).not_to be_empty
				expect(json['id']).to eq(employee_id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:employee_id) { 100 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(response.body).to match(/Couldn't find Employee/)
			end
		end
	end

	# Test suite for POST /employees
	describe 'POST /employees' do
		# valid payload
		let(:valid_attributes) { { name: "Husein Kareem", phone_number: "1234567890", badge_id: "007" } }
		context 'when the request is valid' do 
			before { post '/employees', params: valid_attributes }

			it 'creates a employee' do 
				expect(json['name']).to eq('Husein Kareem')
			end

			it 'returns status code 201' do 
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do 
			before { post '/employees', params: { name: 'Foobar' } }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(response.body).to match(/Validation failed: Created by can't be blank/)
			end
		end
	end

	# Test suite for PUT /employees/:id
	describe 'PUT /employees/:id' do
		let(:valid_attributes) { { name: 'Mr. Kareem' } }

		context 'when the record exists' do
			before { put "/employees/#{employee_id}", params: valid_attributes }

			it 'updates the record' do
				expect(response.body).to be_empty
			end

			it 'returns status code 204' do
				expect(response).to have_http_status(204)
			end
		end
	end

	# Test suite for DELETE /employees/:id
	describe 'DELETE /employees/:id' do
		before { delete "/employees/#{employee_id}" }

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end