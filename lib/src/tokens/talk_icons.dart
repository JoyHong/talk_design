import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TalkIcons extends ThemeExtension<TalkIcons> {
  const TalkIcons({
    // Navigation
    required this.arrowUp,
    required this.arrowDown,
    required this.arrowLeft,
    required this.arrowRight,
    required this.back,
    required this.top,
    // Tabs
    required this.chat,
    required this.call,
    required this.video,
    required this.friend,
    required this.group,
    // Actions
    required this.add,
    required this.addFriends,
    required this.addMembers,
    required this.set,
    required this.more,
    required this.edit,
    required this.delete,
    required this.share,
    required this.download,
    required this.qrcode,
    required this.date,
    // Password visibility
    required this.passwordShow,
    required this.passwordHide,
    // Form
    required this.search,
    required this.clear,
    required this.close,
    required this.check,
    // Status
    required this.circle,
    required this.correctFillingSmall,
    required this.correctFillingSmallDisable,
    required this.correctFillingBig,
    required this.correctWireframe,
    required this.errorSmall,
    required this.errorBig,
    // User roles
    required this.kid,
    required this.parent,
    // Premium (40×40 display size)
    required this.talkPremiumBig,
    required this.talkPremiumSmall,
    required this.familyPremiumBig,
    required this.familyPremiumSmall,
    required this.platinumPremiumBig,
    required this.platinumPremiumSmall,
  });

  // Navigation
  final String arrowUp;
  final String arrowDown;
  final String arrowLeft;
  final String arrowRight;
  final String back;
  final String top;

  // Tabs
  final String chat;
  final String call;
  final String video;
  final String friend;
  final String group;

  // Actions
  final String add;
  final String addFriends;
  final String addMembers;
  final String set;
  final String more;
  final String edit;
  final String delete;
  final String share;
  final String download;
  final String qrcode;
  final String date;

  // Password visibility
  final String passwordShow;
  final String passwordHide;

  // Form
  final String search;
  final String clear;
  final String close;
  final String check;

  // Status
  final String circle;
  final String correctFillingSmall;
  final String correctFillingSmallDisable;
  final String correctFillingBig;
  final String correctWireframe;
  final String errorSmall;
  final String errorBig;

  // User roles
  final String kid;
  final String parent;

  // Premium (40×40 display size)
  final String talkPremiumBig;
  final String talkPremiumSmall;
  final String familyPremiumBig;
  final String familyPremiumSmall;
  final String platinumPremiumBig;
  final String platinumPremiumSmall;

  static const _base = 'packages/talk_design/assets/icons';
  static const _baseLight = '$_base/light';

  @internal
  static const light = TalkIcons(
    arrowUp: '$_baseLight/ic_arrow_up.svg',
    arrowDown: '$_baseLight/ic_arrow_down.svg',
    arrowLeft: '$_baseLight/ic_arrow_left.svg',
    arrowRight: '$_baseLight/ic_arrow_right.svg',
    back: '$_baseLight/ic_back.svg',
    top: '$_baseLight/ic_top.svg',
    chat: '$_baseLight/ic_chat.svg',
    call: '$_baseLight/ic_call.svg',
    video: '$_baseLight/ic_video.svg',
    friend: '$_baseLight/ic_friend.svg',
    group: '$_baseLight/ic_group.svg',
    add: '$_baseLight/ic_add.svg',
    addFriends: '$_baseLight/ic_add_friends.svg',
    addMembers: '$_baseLight/ic_add_members.svg',
    set: '$_baseLight/ic_set.svg',
    more: '$_baseLight/ic_more.svg',
    edit: '$_baseLight/ic_edit.svg',
    delete: '$_baseLight/ic_delete.svg',
    share: '$_baseLight/ic_share.svg',
    download: '$_baseLight/ic_download.svg',
    qrcode: '$_baseLight/ic_qrcode.svg',
    date: '$_baseLight/ic_date.svg',
    passwordShow: '$_baseLight/ic_password_show.svg',
    passwordHide: '$_baseLight/ic_password_hide.svg',
    search: '$_baseLight/ic_search.svg',
    clear: '$_baseLight/ic_clear.svg',
    close: '$_baseLight/ic_close.svg',
    check: '$_baseLight/ic_check.svg',
    circle: '$_baseLight/ic_circle.svg',
    correctFillingSmall: '$_baseLight/ic_correct_filling_small.svg',
    correctFillingSmallDisable: '$_baseLight/ic_correct_filling_small_disable.svg',
    correctFillingBig: '$_baseLight/ic_correct_filling_big.svg',
    correctWireframe: '$_baseLight/ic_correct_wireframe.svg',
    errorSmall: '$_baseLight/ic_error_small.svg',
    errorBig: '$_baseLight/ic_error_big.svg',
    kid: '$_baseLight/ic_kid.svg',
    parent: '$_baseLight/ic_parent.svg',
    talkPremiumBig: '$_baseLight/ic_talk_premium_big.svg',
    talkPremiumSmall: '$_baseLight/ic_talk_premium_small.svg',
    familyPremiumBig: '$_baseLight/ic_family_premium_big.svg',
    familyPremiumSmall: '$_baseLight/ic_family_premium_small.svg',
    platinumPremiumBig: '$_baseLight/ic_platinum_premium_big.svg',
    platinumPremiumSmall: '$_baseLight/ic_platinum_premium_small.svg',
  );

  @override
  TalkIcons copyWith({
    String? arrowUp,
    String? arrowDown,
    String? arrowLeft,
    String? arrowRight,
    String? back,
    String? top,
    String? chat,
    String? call,
    String? video,
    String? friend,
    String? group,
    String? add,
    String? addFriends,
    String? addMembers,
    String? set,
    String? more,
    String? edit,
    String? delete,
    String? share,
    String? download,
    String? qrcode,
    String? date,
    String? passwordShow,
    String? passwordHide,
    String? search,
    String? clear,
    String? close,
    String? check,
    String? circle,
    String? correctFillingSmall,
    String? correctFillingSmallDisable,
    String? correctFillingBig,
    String? correctWireframe,
    String? errorSmall,
    String? errorBig,
    String? kid,
    String? parent,
    String? talkPremiumBig,
    String? talkPremiumSmall,
    String? familyPremiumBig,
    String? familyPremiumSmall,
    String? platinumPremiumBig,
    String? platinumPremiumSmall,
  }) =>
      TalkIcons(
        arrowUp: arrowUp ?? this.arrowUp,
        arrowDown: arrowDown ?? this.arrowDown,
        arrowLeft: arrowLeft ?? this.arrowLeft,
        arrowRight: arrowRight ?? this.arrowRight,
        back: back ?? this.back,
        top: top ?? this.top,
        chat: chat ?? this.chat,
        call: call ?? this.call,
        video: video ?? this.video,
        friend: friend ?? this.friend,
        group: group ?? this.group,
        add: add ?? this.add,
        addFriends: addFriends ?? this.addFriends,
        addMembers: addMembers ?? this.addMembers,
        set: set ?? this.set,
        more: more ?? this.more,
        edit: edit ?? this.edit,
        delete: delete ?? this.delete,
        share: share ?? this.share,
        download: download ?? this.download,
        qrcode: qrcode ?? this.qrcode,
        date: date ?? this.date,
        passwordShow: passwordShow ?? this.passwordShow,
        passwordHide: passwordHide ?? this.passwordHide,
        search: search ?? this.search,
        clear: clear ?? this.clear,
        close: close ?? this.close,
        check: check ?? this.check,
        circle: circle ?? this.circle,
        correctFillingSmall: correctFillingSmall ?? this.correctFillingSmall,
        correctFillingSmallDisable: correctFillingSmallDisable ?? this.correctFillingSmallDisable,
        correctFillingBig: correctFillingBig ?? this.correctFillingBig,
        correctWireframe: correctWireframe ?? this.correctWireframe,
        errorSmall: errorSmall ?? this.errorSmall,
        errorBig: errorBig ?? this.errorBig,
        kid: kid ?? this.kid,
        parent: parent ?? this.parent,
        talkPremiumBig: talkPremiumBig ?? this.talkPremiumBig,
        talkPremiumSmall: talkPremiumSmall ?? this.talkPremiumSmall,
        familyPremiumBig: familyPremiumBig ?? this.familyPremiumBig,
        familyPremiumSmall: familyPremiumSmall ?? this.familyPremiumSmall,
        platinumPremiumBig: platinumPremiumBig ?? this.platinumPremiumBig,
        platinumPremiumSmall: platinumPremiumSmall ?? this.platinumPremiumSmall,
      );

  @override
  TalkIcons lerp(TalkIcons? other, double t) => t < 0.5 ? this : (other ?? this);
}
