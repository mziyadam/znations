class Nation {
  int? id;
  String? name;
  String? imgUrl;
  String? url;
  String? membershipWithinUN;
  String? sovereigntyDispute;
  String? status;

  Nation(
      {this.id,
        this.name,
        this.imgUrl,
        this.url,
        this.membershipWithinUN,
        this.sovereigntyDispute,
        this.status});

  Nation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    url = json['url'];
    membershipWithinUN = json['membershipWithinUN'];
    sovereigntyDispute = json['sovereigntyDispute'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imgUrl'] = this.imgUrl;
    data['url'] = this.url;
    data['membershipWithinUN'] = this.membershipWithinUN;
    data['sovereigntyDispute'] = this.sovereigntyDispute;
    data['status'] = this.status;
    return data;
  }
}
