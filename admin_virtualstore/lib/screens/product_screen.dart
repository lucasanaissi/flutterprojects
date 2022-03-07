import 'package:admin_virtualstore/blocs/products_bloc.dart';
import 'package:admin_virtualstore/validators/product_validators.dart';
import 'package:admin_virtualstore/widgets/products_sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  late DocumentSnapshot? product;

  ProductScreen({Key? key, this.product, required this.categoryId})
      : super(key: key);

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  final ProductBloc _productBloc;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProductScreenState(String categoryId, DocumentSnapshot? product)
      : _productBloc = ProductBloc(
          product: product,
          categoryId: categoryId,
        );

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        hintText: label,
        focusColor: Colors.pinkAccent,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          decorationColor: Colors.pinkAccent,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      );
    }

    const _fieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: StreamBuilder<bool>(
            initialData: false,
            stream: _productBloc.outCreated,
            builder: (context, snapshot) {
              return Text(
                snapshot.data! ? 'Editar produto' : 'Criar produto',
              );
            }),
        backgroundColor: Colors.pinkAccent,
        actions: [
          StreamBuilder<bool>(
              stream: _productBloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
            if (snapshot.data!) {
              return StreamBuilder<bool>(
                  stream: _productBloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: snapshot.data! ? null : (){
                        _productBloc.deleteProduct();
                        Navigator.of(context).pop();
                      },
                    );
                  });
            } else {
              return Container();
            }
          }),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  icon: const Icon(
                    Icons.save,
                  ),
                  onPressed: snapshot.data! ? null : saveProduct,
                );
              }),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
              stream: _productBloc.outData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Imagens',
                      style: _fieldStyle,
                    ),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data!['images'],
                      onSaved: _productBloc.saveImages,
                      validator: validateImage,
                    ),
                    TextFormField(
                      initialValue: snapshot.data!['title'],
                      style: _fieldStyle,
                      decoration: _buildDecoration('Título'),
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data!['desc'],
                      style: _fieldStyle,
                      maxLines: 6,
                      decoration: _buildDecoration('Descrição'),
                      onSaved: _productBloc.saveDesc,
                      validator: validateDesc,
                    ),
                    TextFormField(
                      initialValue: snapshot.data!['price'].toString(),
                      style: _fieldStyle,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: _buildDecoration('Preço'),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tamanhos',
                      style: _fieldStyle,
                    ),
                    ProductsSizes(
                      context: context,
                      initialValue: snapshot.data!['sizes'],
                      onSaved: _productBloc.saveSizes,
                      validator: (s){
                        if (s!.isEmpty) return 'Adicione um tamanho!';
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data!,
                  child: Container(
                    color: snapshot.data! ? Colors.black54 : Colors.transparent,
                  ),
                );
              }),
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.pinkAccent,
          content: Text(
            'Salvando produto...',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      bool success = await _productBloc.saveProduct();

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: success ? Colors.greenAccent : Colors.red,
          content: Text(
            success ? 'Produto salvo!' : 'Erro ao salvar produto!',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}
