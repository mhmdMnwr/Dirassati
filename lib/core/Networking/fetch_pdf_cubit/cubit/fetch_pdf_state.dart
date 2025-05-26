part of 'fetch_pdf_cubit.dart';

abstract class FetchPdfState {}

class FetchPdfInitial extends FetchPdfState {}

class FetchPdfLoading extends FetchPdfState {}

class FetchPdfSuccess extends FetchPdfState {
  final File pdfFile;
  FetchPdfSuccess(this.pdfFile);
}

class FetchPdfError extends FetchPdfState {
  final String error;
  FetchPdfError({required this.error});
}
