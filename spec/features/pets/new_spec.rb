require 'rails_helper'

  describe "when I visit the shelter pets index page" do
    it "I see a link to add a new adoptable pet for that shelter 'Create Pet,' and when I click the link I'm taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      pet_2 = shelter_1.pets.create(name: "Pepper",
                                     age: 3,
                                     sex: "male",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "/shelters/#{shelter_1.id}/pets"

      expect(page).to have_link("Create Pet", href: "/shelters/#{shelter_1.id}/pets/new")
    end
  end

  describe "When I fill in the form with the pet's: image, name, description, age, and sex, and click 'Create Pet'" do
    it "`POST` request is sent to '/shelters/:shelter_id/pets', a new pet is created for that shelter, that pet has a status of 'adoptable', and I am redirected to the Shelter Pets Index page where I can see the new pet listed" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                                    image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      pet_2 = shelter_1.pets.create(name: "Pepper",
                                     age: 3,
                                     sex: "male",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "/shelters/#{shelter_1.id}/pets"

      click_link("Create Pet")

      fill_in('name', :with => 'Skittles')
      fill_in('description', :with => 'fluffy dog')
      fill_in('image', :with => 'https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
      fill_in('age', :with => '5')
      fill_in('sex', :with => 'male')
      click_on 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
      expect(page).to have_content("Skittles")
      expect(page).to have_content("fluffy dog")
      expect(page).to have_content("male")
      expect(page).to have_content("Adoptable")
      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    end
  end

  describe "when I visit the New Pet Page" do
    it "there is a link at the top to the Pets Index Page and Shelters Index page" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")

      visit "/shelters/#{shelter_1.id}/pets/new"

      expect(page).to have_link("Pets", href: '/pets')
      expect(page).to have_link("Shelters", href: '/shelters')
    end
  end
