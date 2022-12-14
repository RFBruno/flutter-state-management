import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                focusNode: _descriptionFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'URL da imagem',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a URL')
                        : Container(
                          width: double.infinity,                          
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
