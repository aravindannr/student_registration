import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegPage extends StatefulWidget {
  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  List<String> _countryCodes = ['+1', '+91', '+44', '+81', '+86'];
  List<String> _genderOptions = ['Male', 'Female', 'Others'];
  String _selectedCountryCode = '+91';
  String? _selectedGender;
  String? _selectedNationality = 'Indian';

  DateTime? _selectedDate;
  final _dateFormat = DateFormat('dd-MM-yyyy');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade200,
        elevation: 0,
        title: Text(
          'Student Registration Form',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
                        labelText: 'Last Name',
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
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
              GestureDetector(
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
                      _dobController.text = _dateFormat.format(_selectedDate!);
                      _calculateAge(_selectedDate!);
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
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
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              TextFormField(
                readOnly: true,
                controller: _ageController,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
                  labelText: 'Nationality',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                hint: Text('Nationality'),
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
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
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String gender = _genderController.text;
                    String dob = _dobController.text;
                    String age = _ageController.text;
                    String address = _addressController.text;
                    String parentName = _parentNameController.text;
                    String guardianName = _guardianNameController.text;
                    String place = _placeController.text;
                    String phoneNumber = _phoneNumberController.text;

                    print('First Name: $firstName');
                    print('Last Name: $lastName');
                    print('Gender: $gender');
                    print('Date of Birth: $dob');
                    print('Age: $age');
                    print('Address: $address');
                    print('Parent Name: $parentName');
                    print('Guardian Name: $guardianName');
                    print('Place: $place');
                    print('Phone Number: $phoneNumber');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
