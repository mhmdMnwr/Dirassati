import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/core/Networking/fetch_pdf_repo.dart';

part 'fetch_pdf_state.dart';

class FetchPdfCubit extends Cubit<FetchPdfState> {
  final FetchPdfRepo _fetchPdfRepo;
  FetchPdfCubit(this._fetchPdfRepo) : super(FetchPdfInitial());

  void fetchPdf(String url, String savePath) async {
    emit(FetchPdfLoading());
    final response = await _fetchPdfRepo.fetchPdf(url, savePath);
    response.when(
      success: (file) {
        emit(FetchPdfSuccess(file));
      },
      failure: (error) {
        String errorMessage =
            "An unknown error occurred while fetching the PDF.";
        if (error.apiErrorModel.message != null) {
          errorMessage = error.apiErrorModel.message!;
        } else {
          errorMessage =
              "PDF fetch failed: No specific error message provided.";
        }
        emit(FetchPdfError(error: errorMessage));
      },
    );
  }
}
