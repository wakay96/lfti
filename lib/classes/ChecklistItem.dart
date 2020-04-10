class ChecklistItem {
  String _description = '';
  bool _checked = false;

  ChecklistItem(String d, bool c) {
    this._description = d;
    this._checked = c;
  }

  updateStatus() {
    this._checked = true;
  }

  toggleCheck() {
    if (isChecked()) {
      _checked = false;
    } else {
      _checked = true;
    }
  }

  bool getStatus() => this._checked;

  void setStatus(bool newStatus) => this._checked = newStatus;

  bool isChecked() => this._checked;

  String getDescription() => this._description;

  void setDescription(String desc) => this._description = desc;
}
