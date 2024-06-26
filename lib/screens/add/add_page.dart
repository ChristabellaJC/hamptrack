import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/components/text_fields.dart';
import 'package:dev_hampter/functions/authentication/auth.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FirestoreService firestoreService = FirestoreService();
  String userID = '';
  bool type = false;
  bool isLoading = true;
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final GlobalKey<DropDownFieldCustomState> dropdownFieldCustomKey =
      GlobalKey<DropDownFieldCustomState>();

  @override
  void initState() {
    super.initState();
    fetchUserID();
  }

  //Fetch userID
  Future<void> fetchUserID() async {
    try {
      final auth = Auth();
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await auth.getUserByEmail(user.email!);
        final userData = userDoc.data();
        if (userData != null) {
          setState(() {
            userID = userData['id'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //Select Date functiom
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: primaryColor,
              onPrimary: whiteColor,
              onSurface: textColor,
              onSecondary: textColor,
              surface: secondaryColor,
              secondary: textColor,
            ),
            dialogBackgroundColor: whiteColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: primaryColor,
                  fontFamily: 'BalooThambi2',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                foregroundColor: primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  //Toggle button income
  void _toggleButtonA() {
    setState(() {
      type = false;
    });
  }

  //Toggle button expense
  void _toggleButtonB() {
    setState(() {
      type = true;
    });
  }

  //Function to submit data
  void _submitData(BuildContext context) {
    int? amount = int.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'Invalid Amount',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return;
    }

    int? categoryId =
        dropdownFieldCustomKey.currentState?.getSelectedCategoryId();
    if (categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'No Category Selected',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return;
    }

    //Convert date String to DateTime
    DateTime? date = DateTime.tryParse(_dateController.text);
    if (date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'Invalid Date',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return;
    }

    //Adding data to firestore
    firestoreService
        .addData(
      userID,
      _noteController.text,
      date,
      type,
      amount,
      categoryId,
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: greenCol,
          content: Text(
            'Data submitted succesfully',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redCol,
          content: Text(
            'Error submitting data: $error',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .1,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: padding,
                height: height * .7,
                width: width,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Button toggles for Income and Expense
                      ButtonToggleExample(
                        type: type,
                        toggleButtonA: _toggleButtonA,
                        toggleButtonB: _toggleButtonB,
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textColor,
                        ),
                        //TextField for amount
                        child: Row(
                          children: [
                            Text(
                              symbol,
                              style: TextStyle(
                                fontFamily: 'BalooThambi2',
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(
                              width: width * .6,
                              child: TextField(
                                controller: _amountController,
                                cursorColor: whiteColor,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                  fontFamily: 'BalooThambi2',
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      //Textfield to pick date
                      CustomTextFieldEmpty(
                        icon: Icons.calendar_today_outlined,
                        text: 'Date',
                        hint: 'YYYY/MM/DD',
                        onTap: () {
                          _selectDate();
                        },
                        textController: _dateController,
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      //Textfield to pick Category
                      DropDownFieldCustom(
                        key: dropdownFieldCustomKey,
                        type: type,
                        width: width * .9,
                        text: 'Category',
                        icon: Icons.widgets,
                        categoryController: _categoryController,
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      //Textfield to write the note
                      CustomTextFieldEmpty(
                        icon: Icons.note_alt_outlined,
                        text: 'Note',
                        hint: 'Notes...',
                        textController: _noteController,
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      //Save button
                      CustomButton(
                        enabledText: 'Save',
                        onPressed: () => _submitData(context),
                        borderRadius: BorderRadius.circular(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
