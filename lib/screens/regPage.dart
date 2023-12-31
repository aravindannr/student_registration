import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final CollectionReference studentdetailes =
      FirebaseFirestore.instance.collection('studentdetailes');
  final List<String> _countryCodes = ['+1', '+91', '+44', '+81', '+86'];
  final List<String> _genderOptions = ['Male', 'Female', 'Others'];
  String _selectedCountryCode = '+91';
  String? _selectedGender;
  String? _selectedNationality = 'Indian';

  DateTime? _selectedDate;
  final _dateFormat = DateFormat('dd-MM-yyyy');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Gender';
    }
    return null;
  }

  String _ageInYearsMonthsDays(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - dob.year;
    int months = currentDate.month - dob.month;
    int days = currentDate.day - dob.day;

    if (days < 0) {
      months--;
      days += DateTime(DateTime.now().year, DateTime.now().month - 1, 0).day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    String yearsString = years > 0 ? '$years years ' : '';
    String monthsString = months > 0 ? '$months months ' : '';
    String daysString = days > 0 ? '$days days old' : '';

    return '$yearsString$monthsString$daysString';
  }

  void _calculateAge(DateTime dob) {
    _ageController.text = _ageInYearsMonthsDays(dob);
  }

  @override
  void initState() {
    super.initState();
    _selectedNationality = 'Indian';
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade200,
        elevation: 0,
        title: const Text(
          'Student Registration Form',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    SizedBox(
                      width: width * .32,
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email address. Must contain "@" symbol.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: _genderOptions.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: _validateGender,
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _dobController.text =
                            _dateFormat.format(_selectedDate!);
                        _calculateAge(_selectedDate!);
                      });
                    }
                  },
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'DOB',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedNationality,
                  onChanged: (value) {
                    setState(() {
                      _selectedNationality = value;
                    });
                  },
                  items: ['Indian'].map((nationality) {
                    return DropdownMenuItem<String>(
                      value: nationality,
                      child: Text(nationality),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Nationality',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: const Text('Nationality'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Nationality';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  controller: _parentNameController,
                  decoration: const InputDecoration(
                    labelText: 'Parent Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Parent Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  controller: _guardianNameController,
                  decoration: const InputDecoration(
                    labelText: 'Guardian Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Guardian Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Place';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedCountryCode,
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value!;
                        });
                      },
                      items: _countryCodes.map((code) {
                        return DropdownMenuItem<String>(
                          value: code,
                          child: SizedBox(
                            height: 56,
                            child: Center(child: Text(code)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          if (value.length != 10) {
                            return 'Enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * .40, height * .06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addtoDatabase();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill out all fields.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addtoDatabase() {
    String phoneNumberWithCode =
        '$_selectedCountryCode${_phoneNumberController.text}';
    final data = {
      'First Name': _firstNameController.text,
      'Last Name': _lastNameController.text,
      'Email Address': _emailController.text,
      'Gender': _selectedGender,
      'Date of Birth': _dobController.text,
      'Age': _ageController.text,
      'Nationality': _selectedNationality,
      'Address': _addressController.text,
      'Parent Name': _parentNameController.text,
      'Guardian Name': _guardianNameController.text,
      'Place': _guardianNameController.text,
      'Phone Number': phoneNumberWithCode,
    };
    studentdetailes.add(data).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Student details added successfully!'),
            duration: Duration(seconds: 2)),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add student details. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
