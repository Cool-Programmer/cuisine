class RecipesController < ApplicationController
  before_action :find_recipes, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def show

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'New recipe created. Nyam Nyam! '
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe updated. More Nyam Nyam!'
    else
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to root_path, notice: 'Recipe deleted'
    end
  end

  # DO DRY
  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end

  def find_recipes
    @recipe = Recipe.find(params[:id])
  end
end
