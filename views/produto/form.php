<h1>Adicionar produto</h1>

<form name="createForm" role="form" novalidate>


	<!-- <div class="row">
		<div ng-show="feedback" class="alert alert-{{feedbackType}}">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <div><span class="{{feedbackIcon}}"></span> {{feedbackMessage}}</div>
		</div>
	</div> --><!-- FEEDBACK MESSAGE -->

	<input type="hidden" ng-model="produto.id" name="id">

	<div class="form-group">
		<label for="nome" class="control-label">Nome: <span class="red">*</span></label>
		<input type="text" class="form-control" ng-model="produto.nome" name="nome" placeholder="Informe o nome do produto" required>
		<span class="help-block" ng-show="createForm.nome.$dirty && createForm.nome.$error.required">O campo é obrigatório</span>
	</div><!-- END INPUT -->

	<div class="form-group">
		<label for="descricao" class="control-label">Descricao:</label>
		<input type="text" class="form-control" ng-model="produto.descricao" name="descricao" placeholder="Informe a descrição do produto">
	</div><!-- END INPUT -->

	<div class="form-group">
		<label for="preco" class="control-label">Preço: <span class="red">*</span></label>
		<input type="text" class="form-control" ng-model="produto.preco" name="preco" placeholder="0,00" required>
		<span class="help-block" ng-show="createForm.preco.$dirty && createForm.preco.$error.required">O campo é obrigatório</span>
	</div><!-- END INPUT -->

	<div class="form-group">
		<label for="quantidade" class="control-label">Quantidade: <span class="red">*</span></label>
		<input type="text" class="form-control" ng-model="produto.quantidade" name="quantidade" placeholder="0" required>
		<span class="help-block" ng-show="createForm.quantidade.$dirty && createForm.quantidade.$error.required">O campo é obrigatório</span>
	</div><!-- END INPUT -->

	<img src="assets/img/ajax-loader.gif" ng-show="isloading">
	<button type="submit" ng-click="saveitem()" ng-class="{disabled: createForm.$invalid}" class="btn btn-primary" ng-disabled="submitting" ng-switch="submitting">
		<span ng-switch-default>Salvar</span>
    	<span ng-switch-when="true">Salvando...</span>
	</button>
	<a href="/produto" class="btn btn-danger">Cancelar</a>

</form>