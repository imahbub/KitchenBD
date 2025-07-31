//
//  RecipeData.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import Foundation

// Centralized recipe data model
struct Recipe: Codable, Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let cookingTime: String
    let servingSize: String
    let ingredients: [String]
    let instructions: [String]
    let origin: String
    let servingTime: ServingTime
    let mainIngredient: MainIngredient
    
    // Convert to CardData for compatibility
    var cardData: CardData {
        CardData(imageName: imageName, title: title, description: description)
    }
}

// Recipe data structure that represents the actual cards (for backward compatibility)
struct CardData: Codable {
    let imageName: String
    let title: String
    let description: String
}

// Enums for filtering
enum ServingTime: String, CaseIterable, Codable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    case dessert = "Dessert"
    
    var displayName: String {
        return self.rawValue
    }
}

enum MainIngredient: String, CaseIterable, Codable {
    case chicken = "Chicken"
    case beef = "Beef"
    case fish = "Fish"
    case vegetables = "Vegetables"
    case pasta = "Pasta"
    case rice = "Rice"
    case dessert = "Dessert"
    
    var displayName: String {
        return self.rawValue
    }
}

// Centralized recipe repository
class RecipeRepository {
    static let shared = RecipeRepository()
    
    private init() {}
    
    let recipes: [Recipe] = [
        Recipe(
            imageName: "vada-pav",
            title: "Vada Pav Recipe",
            description: "This recipe of Vada Pav is twisted to suit Bangladeshi taste buds. It is a popular street food in India, and now you can make it at home!",
            cookingTime: "60 mins",
            servingSize: "10 servings",
            ingredients: [
                "Main Ingredients:",
                "Pao bread (10 pieces)",
                "Potato Chops (Vada)",
                "Green Chutney",
                "Red Chutney",
                "Fried Green Chillies",
                "=================",
                "For Potato Chops (Vada):",
                "Medium-sized potatoes: 5-6 (for 10 Vada)",
                "Oil: 2 tablespoons (for cooking the potato mixture)",
                "Onion paste: 1 tablespoon",
                "Ginger-garlic paste: 1/3 tablespoon",
                "Cumin seeds: 1 tablespoon",
                "Coriander powder: 1 tablespoon",
                "Nigella seeds (kalonji): 1 tablespoon",
                "Salt: To taste",
                "Chickpea flour (Besan): 250 grams",
                "Turmeric powder: 1/3 tablespoon (for the potato mixture)",
                "Red chili powder: 1/3 tablespoon (for the batter)",
                "Coriander powder: 1/3 tablespoon (for the batter)",
                "Cumin powder: 1/3 tablespoon (for the batter)",
                "Water: As needed (for the batter)",
                "Oil: Large quantity for deep frying",
                "=================",
                "For Green Chutney:",
                "Green chilies: 5-6 pieces (or to your spice preference)",
                "Coriander leaves: 1 bunch",
                "Mint leaves: (Optional)",
                "Garlic cloves: 5-6",
                "Salt: To taste",
                "Sugar: 1/4 tablespoon",
                "Water: 2 tablespoons",
                "=================",
                "For Red Chutney:",
                "Fried chickpea flour batter pops: As needed",
                "Peanuts: 1 tablespoon",
                "Garlic cloves: 5-6",
                "Red chili powder: To your preference",
                "Salt: To taste",
                "=================",
                "For Fried Green Chillies:",
                "Large green chilies: 8-10 pieces"
            ],
            instructions: [
                "Step 1: Prepare the Potato Mixture",
                "Boil and mash the potatoes. Set aside",
                "Heat 2 tablespoons of oil in a pan",
                "Add cumin seeds and nigella seeds. Stir until fragrant",
                "Add onion paste and green chilies. Sauté until soft",
                "Add ginger-garlic paste and turmeric powder. Stir well",
                "Add salt to taste",
                "Add the mashed potatoes to the pan and stir thoroughly until well combined and cooked",
                "Remove the pan from the stove and transfer the potato mixture to a plate. Allow it to cool completely",
                "Step 2: Prepare the Batter and Fry",
                "In a bowl, combine chickpea flour, turmeric powder, red chili powder, cumin powder, and coriander powder",
                "Optionally, add ginger-garlic paste for enhanced flavor",
                "Gradually add water and mix to form a smooth, lump-free batter of medium consistency",
                "Once the potato mixture has cooled, shape it into small, round patties (Vada)",
                "Dip each potato patty into the chickpea flour batter, ensuring it's fully coated",
                "Heat a large quantity of oil in a deep pan or wok over medium heat",
                "Carefully place the coated potato patties into the hot oil",
                "Fry the Vada on low to medium heat until golden brown and cooked through. Remove and drain on paper towels",
                "Step 3: Prepare Green Chutney",
                "Combine all ingredients (green chilies, coriander leaves, mint leaves, garlic, salt, sugar, and water) in a grinder jar",
                "Blend until a smooth, fine paste is formed",
                "Transfer the chutney to a small serving bowl",
                "Step 4: Prepare Red Chutney",
                "After frying the Vada, drop any remaining chickpea flour batter into the hot oil in small, irregular shapes to create 'pops.' Fry until crispy. Remove and place in a bowl",
                "In the same oil, fry the garlic cloves and peanuts until golden brown. Remove and add to the bowl with the batter pops",
                "Allow the batter pops, peanuts, and garlic to cool completely",
                "Once cooled, transfer them to a grinder jar. Add red chili powder and salt",
                "Grind until a coarse powder or desired consistency is achieved",
                "Step 5: Prepare Fried Green Chillies",
                "Make a small, vertical slit in each green chili before frying",
                "Fry the green chilies in hot oil for a few minutes until slightly blistered. Remove and drain",
                "Step 6: Assembling Your Vada Pav",
                "Take a pao bread and slice it horizontally, but not all the way through, creating a pocket",
                "Spread green chutney on the upper half of the pao and red chutney on the lower half",
                "Place a hot potato chop (Vada) inside the pao",
                "Serve immediately, accompanied by the fried green chilies. Enjoy your Vada Pav!"
            ],
            origin: "India",
            servingTime: .snack,
            mainIngredient: .vegetables
        ),
        Recipe(
            imageName: "fried-chicken",
            title: "Fried Chicken Recipe",
            description: "Crispy outer shell and soft and juicy inner everytime",
            cookingTime: "45 mins",
            servingSize: "4 servings",
            ingredients: [
                "5 large chicken drumsticks (500g total)",
                "Salt - 1/4 tbsp per liter of water",
                "Water - As required to submerge drumsticks",
                "Sour curd - 2 tbsp",
                "Lemon juice - 1 tbsp",
                "Red chilli powder - 1 tbsp",
                "Black pepper - 1/2 tbsp",
                "White pepper - 1/4 tbsp",
                "Garam masala mix powder - as required",
                "Chicken bullion powder - 1/4 tbsp (optional)",
                "Paprika - 1/4 tbsp",
                "Onion powder - 1/2 tbsp",
                "Garlic powder - 1/2 tbsp",
                "Ginger powder - 1/2 tbsp",
                "1 egg",
                "Milk - less than 1/2 cup",
                "Cornflour and flour - 1.5 cups flour + 1/2 cup cornflour",
                "Mixed ground herbs - as required",
                "Oil for deep frying"
            ],
            instructions: [
                "Brining: Submerge drumsticks in water with salt, sour curd, and lemon juice. Soak for 2 hours, then pat dry",
                "Marinate: Mix salt, red chilli powder, black pepper, white pepper, garam masala, paprika, onion powder, garlic powder, and ginger powder. Coat chicken thoroughly and refrigerate for minimum 4 hours",
                "Make batter: Whisk 1 egg with less than 1/2 cup milk and optional black pepper",
                "Prepare coating: Mix 1.5 cups flour with 1/2 cup cornflour, salt, black pepper, garlic powder, ginger powder, and mixed herbs",
                "Coat and fry: Heat oil to 325°C, coat chicken with batter then flour, fry for 13-15 minutes with lid closed, flip after 7 minutes",
                "Rest and serve: Drain excess oil on paper towels, let cool to safe temperature, serve with garlic chilli sauce or ketchup"
            ],
            origin: "Bangladesh",
            servingTime: .dinner,
            mainIngredient: .chicken
        ),
        Recipe(
            imageName: "beef-curry",
            title: "Beef Curry",
            description: "Spicy beef curry with aromatic spices and tender meat",
            cookingTime: "2 hours",
            servingSize: "6 servings",
            ingredients: [
                "500g beef, cubed",
                "2 onions, chopped",
                "3 tomatoes, chopped",
                "2 tbsp curry powder",
                "1 tsp turmeric",
                "1 tsp cumin",
                "2 tbsp oil",
                "Salt to taste"
            ],
            instructions: [
                "Heat oil in a large pot",
                "Add onions and cook until golden",
                "Add beef and brown on all sides",
                "Add spices and cook for 2 minutes",
                "Add tomatoes and cook until soft",
                "Simmer for 1 hour until beef is tender"
            ],
            origin: "India",
            servingTime: .dinner,
            mainIngredient: .beef
        ),
        Recipe(
            imageName: "fish-fry",
            title: "Fish Fry",
            description: "Crispy fish fry with golden brown coating",
            cookingTime: "25 mins",
            servingSize: "4 servings",
            ingredients: [
                "4 fish fillets",
                "1 cup breadcrumbs",
                "2 eggs",
                "1 tsp salt",
                "1 tsp pepper",
                "1 tsp paprika",
                "Oil for frying",
                "Lemon wedges"
            ],
            instructions: [
                "Season fish with salt and pepper",
                "Beat eggs in a bowl",
                "Dip fish in eggs, then coat with breadcrumbs",
                "Heat oil in a pan",
                "Fry fish for 3-4 minutes each side",
                "Serve with lemon wedges"
            ],
            origin: "Bangladesh",
            servingTime: .lunch,
            mainIngredient: .fish
        ),
        Recipe(
            imageName: "chicken-biryani",
            title: "Chicken Biryani",
            description: "Fragrant rice dish with tender chicken and aromatic spices",
            cookingTime: "1 hour 30 mins",
            servingSize: "8 servings",
            ingredients: [
                "2 cups basmati rice",
                "500g chicken, cubed",
                "2 onions, sliced",
                "1 cup yogurt",
                "2 tbsp biryani masala",
                "Saffron strands",
                "Ghee",
                "Fresh mint and coriander"
            ],
            instructions: [
                "Marinate chicken with yogurt and spices",
                "Cook rice until 70% done",
                "Layer rice and chicken in a pot",
                "Add saffron and ghee",
                "Cook on low heat for 30 minutes",
                "Garnish with mint and coriander"
            ],
            origin: "India",
            servingTime: .dinner,
            mainIngredient: .rice
        ),
        Recipe(
            imageName: "vegetable-stir-fry",
            title: "Vegetable Stir Fry",
            description: "Fresh vegetables stir-fried with soy sauce and garlic",
            cookingTime: "15 mins",
            servingSize: "3 servings",
            ingredients: [
                "2 cups mixed vegetables",
                "2 tbsp soy sauce",
                "1 tbsp garlic, minced",
                "1 tbsp ginger, minced",
                "2 tbsp oil",
                "1 tsp sesame oil",
                "Salt and pepper",
                "Green onions"
            ],
            instructions: [
                "Heat oil in a wok",
                "Add garlic and ginger, stir for 30 seconds",
                "Add vegetables and stir-fry for 5 minutes",
                "Add soy sauce and sesame oil",
                "Cook for 2 more minutes",
                "Garnish with green onions"
            ],
            origin: "China",
            servingTime: .lunch,
            mainIngredient: .vegetables
        ),
        Recipe(
            imageName: "pasta-carbonara",
            title: "Pasta Carbonara",
            description: "Creamy pasta with bacon, eggs, and parmesan cheese",
            cookingTime: "20 mins",
            servingSize: "4 servings",
            ingredients: [
                "400g spaghetti",
                "200g pancetta or bacon",
                "4 egg yolks",
                "1 cup parmesan cheese",
                "Black pepper",
                "Salt",
                "Olive oil",
                "Fresh parsley"
            ],
            instructions: [
                "Cook pasta according to package instructions",
                "Cook pancetta until crispy",
                "Mix egg yolks with parmesan and pepper",
                "Add hot pasta to egg mixture",
                "Add pancetta and pasta water",
                "Serve immediately with extra cheese"
            ],
            origin: "Italy",
            servingTime: .dinner,
            mainIngredient: .pasta
        ),
        Recipe(
            imageName: "grilled-salmon",
            title: "Grilled Salmon",
            description: "Perfectly grilled salmon with herbs and lemon",
            cookingTime: "30 mins",
            servingSize: "4 servings",
            ingredients: [
                "4 salmon fillets",
                "2 lemons",
                "Fresh herbs (dill, thyme)",
                "Olive oil",
                "Salt and pepper",
                "Garlic cloves",
                "Butter",
                "Lemon zest"
            ],
            instructions: [
                "Preheat grill to medium-high",
                "Season salmon with salt, pepper, and herbs",
                "Brush with olive oil",
                "Grill for 4-5 minutes each side",
                "Add lemon slices and butter",
                "Serve with fresh herbs"
            ],
            origin: "Mediterranean",
            servingTime: .dinner,
            mainIngredient: .fish
        ),
        Recipe(
            imageName: "chocolate-cake",
            title: "Chocolate Cake",
            description: "Rich and moist chocolate cake with chocolate frosting",
            cookingTime: "1 hour 15 mins",
            servingSize: "12 servings",
            ingredients: [
                "2 cups all-purpose flour",
                "2 cups sugar",
                "3/4 cup cocoa powder",
                "2 eggs",
                "1 cup milk",
                "1/2 cup vegetable oil",
                "2 tsp vanilla extract",
                "1 tsp baking soda"
            ],
            instructions: [
                "Preheat oven to 350°F (175°C)",
                "Mix dry ingredients in a bowl",
                "Beat eggs, milk, oil, and vanilla",
                "Combine wet and dry ingredients",
                "Pour into greased cake pan",
                "Bake for 30-35 minutes"
            ],
            origin: "France",
            servingTime: .dessert,
            mainIngredient: .dessert
        )
    ]
    
    // Helper method to get recipe by title
    func getRecipe(by title: String) -> Recipe? {
        return recipes.first { $0.title == title }
    }
    
    // Helper method to get all recipes as CardData
    var allCardData: [CardData] {
        return recipes.map { $0.cardData }
    }
    
    // Helper method to get all recipes
    var allRecipes: [Recipe] {
        return recipes
    }
    
    // Helper method to get unique origins
    var uniqueOrigins: [String] {
        return Array(Set(recipes.map { $0.origin })).sorted()
    }
    
    // MARK: - Adding New Recipes
    // To add a new recipe, simply add a new Recipe object to the recipes array above.
    // The recipe will automatically appear in:
    // - ContentView (main recipe list)
    // - RecipeView (detailed view with ingredients and instructions)
    // - Search functionality
    // - Favorites system
    // - Filtering system (origin, serving time, main ingredient)
    //
    // Example of adding a new recipe:
    // Recipe(
    //     imageName: "new-recipe-image",
    //     title: "New Recipe Name",
    //     description: "Brief description of the recipe",
    //     cookingTime: "30 mins",
    //     servingSize: "4 servings",
    //     ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"],
    //     instructions: ["Step 1", "Step 2", "Step 3"],
    //     origin: "Country Name",
    //     servingTime: .lunch,
    //     mainIngredient: .chicken
    // )
} 
