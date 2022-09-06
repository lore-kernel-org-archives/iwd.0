Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B486E6
	for <iwd@lists.linux.dev>; Tue,  6 Sep 2022 19:22:10 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id io18so3558256plb.10
        for <iwd@lists.linux.dev>; Tue, 06 Sep 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OFq1f7OQDLvljNurKXcsWxlfio9SllcbGo44/MF6x+o=;
        b=Bd1H3Q+8LJe7hHXNxSpNw4DrwjnseyFR3pSoT5KXW/ZRACd/xcyY6Zz6kl/FQTMxme
         BaatnWothXTECfVPVFi9PYHnj/XY4M9jQPfH6qDUWroDToe1nmWJIoYua5EZOsCKS3Lo
         xLKPP2/6G3h/MBvv98L0POMoBtD9mf7pGI05F6XxNJs7W7nrDj7NPuLBrmJmFvF7YG8g
         PyJKrYXaJJ2FvgFDQRtPEj6XwVA5k7iA8ywekHPCK5NaDsz4Hwg5hF1GCJrz8PxSvSDP
         ZEeyvEdAr1amGd55wZ/NtVHjwqxyuWL8PBfGWfJnlyz/06tUEeyVOc3rcOEXCAvMa7mc
         eD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OFq1f7OQDLvljNurKXcsWxlfio9SllcbGo44/MF6x+o=;
        b=XCAZuTn78Dg33FOq1+ZSf/q25fc/h/hXkWKWHuU/PIf2yXYhO1Z9FtsrFGjjPtz/7Z
         tienVjq04Imu4euWdGu90blhppNUEWWeifiukp08a2hNut4eqUQsgF8IF8EktbuEh04G
         1U70lSAUyn4nPdMy7aabtP5PMuslZAcJItt8K3gqe7hAbbMbvGZkZ3fsEldoO7JzfJxq
         L2uyWjoD2g6+E/S3PORwqYo15AOGamuxS3rud0j5rPMMED9PJ0kGHLmAdAsRDPY0SWxM
         HTczaUrrhYtLcB3iyzOqPlW+x2arCS8whDCOqnWdh0faGmhbMiB2yQjO3djtrDBKfEV6
         yMFQ==
X-Gm-Message-State: ACgBeo399njQX9Y7+p0mD60OfcGjH7KiVcC+jH1m5bbWZAIBjoS74lxk
	6C2IHenwd28zeoAq9JqBj+qGcrOXmRo=
X-Google-Smtp-Source: AA6agR59Rjoonb8zPM0RZFF4TdSquqAULHAiK4hHQV5ZH786CK2au5wVUK5t7NlitVFrv9/ZCHGNKA==
X-Received: by 2002:a17:902:8605:b0:16b:e755:3c6e with SMTP id f5-20020a170902860500b0016be7553c6emr12585plo.42.1662492129392;
        Tue, 06 Sep 2022 12:22:09 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00172f6726d8esm10206654pln.277.2022.09.06.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:22:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] Update nl80211.h (wireless-next/main)
Date: Tue,  6 Sep 2022 12:22:05 -0700
Message-Id: <20220906192207.84986-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 linux/nl80211.h | 459 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 440 insertions(+), 19 deletions(-)

diff --git a/linux/nl80211.h b/linux/nl80211.h
index f962c06e..c32e7616 100644
--- a/linux/nl80211.h
+++ b/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -300,6 +300,40 @@
  * the interface goes down.
  */
 
+/**
+ * DOC: FILS shared key crypto offload
+ *
+ * This feature is applicable to drivers running in AP mode.
+ *
+ * FILS shared key crypto offload can be advertised by drivers by setting
+ * @NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD flag. The drivers that support
+ * FILS shared key crypto offload should be able to encrypt and decrypt
+ * association frames for FILS shared key authentication as per IEEE 802.11ai.
+ * With this capability, for FILS key derivation, drivers depend on userspace.
+ *
+ * After FILS key derivation, userspace shares the FILS AAD details with the
+ * driver and the driver stores the same to use in decryption of association
+ * request and in encryption of association response. The below parameters
+ * should be given to the driver in %NL80211_CMD_SET_FILS_AAD.
+ *	%NL80211_ATTR_MAC - STA MAC address, used for storing FILS AAD per STA
+ *	%NL80211_ATTR_FILS_KEK - Used for encryption or decryption
+ *	%NL80211_ATTR_FILS_NONCES - Used for encryption or decryption
+ *			(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
+ *
+ * Once the association is done, the driver cleans the FILS AAD data.
+ */
+
+/**
+ * DOC: Multi-Link Operation
+ *
+ * In Multi-Link Operation, a connection between to MLDs utilizes multiple
+ * links. To use this in nl80211, various commands and responses now need
+ * to or will include the new %NL80211_ATTR_MLO_LINKS attribute.
+ * Additionally, various commands that need to operate on a specific link
+ * now need to be given the %NL80211_ATTR_MLO_LINK_ID attribute, e.g. to
+ * use %NL80211_CMD_START_AP or similar functions.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -337,17 +371,28 @@
  * @NL80211_CMD_DEL_INTERFACE: Virtual interface was deleted, has attributes
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_WIPHY. Can also be sent from
  *	userspace to request deletion of a virtual interface, then requires
- *	attribute %NL80211_ATTR_IFINDEX.
+ *	attribute %NL80211_ATTR_IFINDEX. If multiple BSSID advertisements are
+ *	enabled using %NL80211_ATTR_MBSSID_CONFIG, %NL80211_ATTR_MBSSID_ELEMS,
+ *	and if this command is used for the transmitting interface, then all
+ *	the non-transmitting interfaces are deleted as well.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
- *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
+ *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC
+ *	represents peer's MLD address for MLO pairwise key. For MLO group key,
+ *	the link is identified by %NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_SET_KEY: Set key attributes %NL80211_ATTR_KEY_DEFAULT,
  *	%NL80211_ATTR_KEY_DEFAULT_MGMT, or %NL80211_ATTR_KEY_THRESHOLD.
+ *	For MLO connection, the link to set default key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
  *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
- *	and %NL80211_ATTR_KEY_SEQ attributes.
+ *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
+ *	peer's MLD address for MLO pairwise key. The link to add MLO
+ *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_IDX
- *	or %NL80211_ATTR_MAC.
+ *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
+ *	for MLO pairwise key. The link to delete group key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  *
  * @NL80211_CMD_GET_BEACON: (not used)
  * @NL80211_CMD_SET_BEACON: change the beacon on an access point interface
@@ -727,6 +772,13 @@
  *	%NL80211_ATTR_CSA_C_OFFSETS_TX is an array of offsets to CSA
  *	counters which will be updated to the current value. This attribute
  *	is used during CSA period.
+ *	For TX on an MLD, the frequency can be omitted and the link ID be
+ *	specified, or if transmitting to a known peer MLD (with MLD addresses
+ *	in the frame) both can be omitted and the link will be selected by
+ *	lower layers.
+ *	For RX notification, %NL80211_ATTR_RX_HW_TIMESTAMP may be included to
+ *	indicate the frame RX timestamp and %NL80211_ATTR_TX_HW_TIMESTAMP may
+ *	be included to indicate the ack TX timestamp.
  * @NL80211_CMD_FRAME_WAIT_CANCEL: When an off-channel TX was requested, this
  *	command may be used with the corresponding cookie to cancel the wait
  *	time if it is known that it is no longer necessary.  This command is
@@ -737,7 +789,9 @@
  *	transmitted with %NL80211_CMD_FRAME. %NL80211_ATTR_COOKIE identifies
  *	the TX command and %NL80211_ATTR_FRAME includes the contents of the
  *	frame. %NL80211_ATTR_ACK flag is included if the recipient acknowledged
- *	the frame.
+ *	the frame. %NL80211_ATTR_TX_HW_TIMESTAMP may be included to indicate the
+ *	tx timestamp and %NL80211_ATTR_RX_HW_TIMESTAMP may be included to
+ *	indicate the ack RX timestamp.
  * @NL80211_CMD_ACTION_TX_STATUS: Alias for @NL80211_CMD_FRAME_TX_STATUS for
  *	backward compatibility.
  *
@@ -1082,6 +1136,12 @@
  *	has been received. %NL80211_ATTR_FRAME is used to specify the
  *	frame contents.  The frame is the raw EAPoL data, without ethernet or
  *	802.11 headers.
+ *	For an MLD transmitter, the %NL80211_ATTR_MLO_LINK_ID may be given and
+ *	its effect will depend on the destination: If the destination is known
+ *	to be an MLD, this will be used as a hint to select the link to transmit
+ *	the frame on. If the destination is not an MLD, this will select both
+ *	the link to transmit on and the source address will be set to the link
+ *	address of that link.
  *	When used as an event indication %NL80211_ATTR_CONTROL_PORT_ETHERTYPE,
  *	%NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT and %NL80211_ATTR_MAC are added
  *	indicating the protocol type of the received frame; whether the frame
@@ -1185,6 +1245,42 @@
  *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
  *	specify the wiphy index to be applied to.
  *
+ * @NL80211_CMD_OBSS_COLOR_COLLISION: This notification is sent out whenever
+ *	mac80211/drv detects a bss color collision.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_REQUEST: This command is used to indicate that
+ *	userspace wants to change the BSS color.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_STARTED: Notify userland, that a color change has
+ *	started
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ABORTED: Notify userland, that the color change has
+ *	been aborted
+ *
+ * @NL80211_CMD_COLOR_CHANGE_COMPLETED: Notify userland that the color change
+ *	has completed
+ *
+ * @NL80211_CMD_SET_FILS_AAD: Set FILS AAD data to the driver using -
+ *	&NL80211_ATTR_MAC - for STA MAC address
+ *	&NL80211_ATTR_FILS_KEK - for KEK
+ *	&NL80211_ATTR_FILS_NONCES - for FILS Nonces
+ *		(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
+ *
+ * @NL80211_CMD_ASSOC_COMEBACK: notification about an association
+ *      temporal rejection with comeback. The event includes %NL80211_ATTR_MAC
+ *      to describe the BSSID address of the AP and %NL80211_ATTR_TIMEOUT to
+ *      specify the timeout value.
+ *
+ * @NL80211_CMD_ADD_LINK: Add a new link to an interface. The
+ *	%NL80211_ATTR_MLO_LINK_ID attribute is used for the new link.
+ * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This may come
+ *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
+ *	in preparation for e.g. roaming to a regular (non-MLO) AP.
+ *
+ * @NL80211_CMD_ADD_LINK_STA: Add a link to an MLD station
+ * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
+ * @NL80211_CMD_REMOVE_LINK_STA: Remove a link of an MLD station
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1417,6 +1513,25 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_OBSS_COLOR_COLLISION,
+
+	NL80211_CMD_COLOR_CHANGE_REQUEST,
+
+	NL80211_CMD_COLOR_CHANGE_STARTED,
+	NL80211_CMD_COLOR_CHANGE_ABORTED,
+	NL80211_CMD_COLOR_CHANGE_COMPLETED,
+
+	NL80211_CMD_SET_FILS_AAD,
+
+	NL80211_CMD_ASSOC_COMEBACK,
+
+	NL80211_CMD_ADD_LINK,
+	NL80211_CMD_REMOVE_LINK,
+
+	NL80211_CMD_ADD_LINK_STA,
+	NL80211_CMD_MODIFY_LINK_STA,
+	NL80211_CMD_REMOVE_LINK_STA,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2276,8 +2391,10 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_IFTYPE_EXT_CAPA: Nested attribute of the following attributes:
  *	%NL80211_ATTR_IFTYPE, %NL80211_ATTR_EXT_CAPA,
- *	%NL80211_ATTR_EXT_CAPA_MASK, to specify the extended capabilities per
- *	interface type.
+ *	%NL80211_ATTR_EXT_CAPA_MASK, to specify the extended capabilities and
+ *	other interface-type specific capabilities per interface type. For MLO,
+ *	%NL80211_ATTR_EML_CAPABILITY and %NL80211_ATTR_MLD_CAPA_AND_OPS are
+ *	present.
  *
  * @NL80211_ATTR_MU_MIMO_GROUP_DATA: array of 24 bytes that defines a MU-MIMO
  *	groupID for monitor mode.
@@ -2413,7 +2530,9 @@ enum nl80211_commands {
  *	space supports external authentication. This attribute shall be used
  *	with %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP request. The driver
  *	may offload authentication processing to user space if this capability
- *	is indicated in the respective requests from the user space.
+ *	is indicated in the respective requests from the user space. (This flag
+ *	attribute deprecated for %NL80211_CMD_START_AP, use
+ *	%NL80211_ATTR_AP_SETTINGS_FLAGS)
  *
  * @NL80211_ATTR_NSS: Station's New/updated  RX_NSS value notified using this
  *	u8 attribute. This is used with %NL80211_CMD_STA_OPMODE_CHANGED.
@@ -2560,6 +2679,76 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the u64 BSS colors for the
+ *	%NL80211_CMD_OBSS_COLOR_COLLISION event.
+ *
+ * @NL80211_ATTR_COLOR_CHANGE_COUNT: u8 attribute specifying the number of TBTT's
+ *	until the color switch event.
+ * @NL80211_ATTR_COLOR_CHANGE_COLOR: u8 attribute specifying the color that we are
+ *	switching to
+ * @NL80211_ATTR_COLOR_CHANGE_ELEMS: Nested set of attributes containing the IE
+ *	information for the time while performing a color switch.
+ *
+ * @NL80211_ATTR_MBSSID_CONFIG: Nested attribute for multiple BSSID
+ *	advertisements (MBSSID) parameters in AP mode.
+ *	Kernel uses this attribute to indicate the driver's support for MBSSID
+ *	and enhanced multi-BSSID advertisements (EMA AP) to the userspace.
+ *	Userspace should use this attribute to configure per interface MBSSID
+ *	parameters.
+ *	See &enum nl80211_mbssid_config_attributes for details.
+ *
+ * @NL80211_ATTR_MBSSID_ELEMS: Nested parameter to pass multiple BSSID elements.
+ *	Mandatory parameter for the transmitting interface to enable MBSSID.
+ *	Optional for the non-transmitting interfaces.
+ *
+ * @NL80211_ATTR_RADAR_BACKGROUND: Configure dedicated offchannel chain
+ *	available for radar/CAC detection on some hw. This chain can't be used
+ *	to transmit or receive frames and it is bounded to a running wdev.
+ *	Background radar/CAC detection allows to avoid the CAC downtime
+ *	switching on a different channel during CAC detection on the selected
+ *	radar channel.
+ *
+ * @NL80211_ATTR_AP_SETTINGS_FLAGS: u32 attribute contains ap settings flags,
+ *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
+ *	used with %NL80211_CMD_START_AP request.
+ *
+ * @NL80211_ATTR_EHT_CAPABILITY: EHT Capability information element (from
+ *	association request when used with NL80211_CMD_NEW_STATION). Can be set
+ *	only if %NL80211_STA_FLAG_WME is set.
+ *
+ * @NL80211_ATTR_MLO_LINK_ID: A (u8) link ID for use with MLO, to be used with
+ *	various commands that need a link ID to operate.
+ * @NL80211_ATTR_MLO_LINKS: A nested array of links, each containing some
+ *	per-link information and a link ID.
+ * @NL80211_ATTR_MLD_ADDR: An MLD address, used with various commands such as
+ *	authenticate/associate.
+ *
+ * @NL80211_ATTR_MLO_SUPPORT: Flag attribute to indicate user space supports MLO
+ *	connection. Used with %NL80211_CMD_CONNECT. If this attribute is not
+ *	included in NL80211_CMD_CONNECT drivers must not perform MLO connection.
+ *
+ * @NL80211_ATTR_MAX_NUM_AKM_SUITES: U16 attribute. Indicates maximum number of
+ *	AKM suites allowed for %NL80211_CMD_CONNECT, %NL80211_CMD_ASSOCIATE and
+ *	%NL80211_CMD_START_AP in %NL80211_CMD_GET_WIPHY response. If this
+ *	attribute is not present userspace shall consider maximum number of AKM
+ *	suites allowed as %NL80211_MAX_NR_AKM_SUITES which is the legacy maximum
+ *	number prior to the introduction of this attribute.
+ *
+ * @NL80211_ATTR_EML_CAPABILITY: EML Capability information (u16)
+ * @NL80211_ATTR_MLD_CAPA_AND_OPS: MLD Capabilities and Operations (u16)
+ *
+ * @NL80211_ATTR_TX_HW_TIMESTAMP: Hardware timestamp for TX operation in
+ *	nanoseconds (u64). This is the device clock timestamp so it will
+ *	probably reset when the device is stopped or the firmware is reset.
+ *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the frame TX
+ *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
+ *	the ack TX timestamp.
+ * @NL80211_ATTR_RX_HW_TIMESTAMP: Hardware timestamp for RX operation in
+ *	nanoseconds (u64). This is the device clock timestamp so it will
+ *	probably reset when the device is stopped or the firmware is reset.
+ *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
+ *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
+ *	the incoming frame RX timestamp.
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3246,37 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_OBSS_COLOR_BITMAP,
+
+	NL80211_ATTR_COLOR_CHANGE_COUNT,
+	NL80211_ATTR_COLOR_CHANGE_COLOR,
+	NL80211_ATTR_COLOR_CHANGE_ELEMS,
+
+	NL80211_ATTR_MBSSID_CONFIG,
+	NL80211_ATTR_MBSSID_ELEMS,
+
+	NL80211_ATTR_RADAR_BACKGROUND,
+
+	NL80211_ATTR_AP_SETTINGS_FLAGS,
+
+	NL80211_ATTR_EHT_CAPABILITY,
+
+	NL80211_ATTR_DISABLE_EHT,
+
+	NL80211_ATTR_MLO_LINKS,
+	NL80211_ATTR_MLO_LINK_ID,
+	NL80211_ATTR_MLD_ADDR,
+
+	NL80211_ATTR_MLO_SUPPORT,
+
+	NL80211_ATTR_MAX_NUM_AKM_SUITES,
+
+	NL80211_ATTR_EML_CAPABILITY,
+	NL80211_ATTR_MLD_CAPA_AND_OPS,
+
+	NL80211_ATTR_TX_HW_TIMESTAMP,
+	NL80211_ATTR_RX_HW_TIMESTAMP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3111,7 +3331,14 @@ enum nl80211_attrs {
 #define NL80211_HE_MIN_CAPABILITY_LEN           16
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
+
+/*
+ * NL80211_MAX_NR_AKM_SUITES is obsolete when %NL80211_ATTR_MAX_NUM_AKM_SUITES
+ * present in %NL80211_CMD_GET_WIPHY response.
+ */
 #define NL80211_MAX_NR_AKM_SUITES		2
+#define NL80211_EHT_MIN_CAPABILITY_LEN          13
+#define NL80211_EHT_MAX_CAPABILITY_LEN          51
 
 #define NL80211_MIN_REMAIN_ON_CHANNEL_TIME	10
 
@@ -3139,7 +3366,7 @@ enum nl80211_attrs {
  *	and therefore can't be created in the normal ways, use the
  *	%NL80211_CMD_START_P2P_DEVICE and %NL80211_CMD_STOP_P2P_DEVICE
  *	commands to create and destroy one
- * @NL80211_IF_TYPE_OCB: Outside Context of a BSS
+ * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
@@ -3280,6 +3507,56 @@ enum nl80211_he_ru_alloc {
 	NL80211_RATE_INFO_HE_RU_ALLOC_2x996,
 };
 
+/**
+ * enum nl80211_eht_gi - EHT guard interval
+ * @NL80211_RATE_INFO_EHT_GI_0_8: 0.8 usec
+ * @NL80211_RATE_INFO_EHT_GI_1_6: 1.6 usec
+ * @NL80211_RATE_INFO_EHT_GI_3_2: 3.2 usec
+ */
+enum nl80211_eht_gi {
+	NL80211_RATE_INFO_EHT_GI_0_8,
+	NL80211_RATE_INFO_EHT_GI_1_6,
+	NL80211_RATE_INFO_EHT_GI_3_2,
+};
+
+/**
+ * enum nl80211_eht_ru_alloc - EHT RU allocation values
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_26: 26-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_52: 52-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_52P26: 52+26-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_106: 106-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_106P26: 106+26 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_242: 242-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_484: 484-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_484P242: 484+242 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996: 996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996P484: 996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242: 996+484+242 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_2x996: 2x996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484: 2x996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_3x996: 3x996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484: 3x996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_4x996: 4x996-tone RU allocation
+ */
+enum nl80211_eht_ru_alloc {
+	NL80211_RATE_INFO_EHT_RU_ALLOC_26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_52,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_52P26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_106,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_106P26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_484P242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_2x996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_3x996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_4x996,
+};
+
 /**
  * enum nl80211_rate_info - bitrate information
  *
@@ -3319,6 +3596,13 @@ enum nl80211_he_ru_alloc {
  * @NL80211_RATE_INFO_HE_DCM: HE DCM value (u8, 0/1)
  * @NL80211_RATE_INFO_RU_ALLOC: HE RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_he_ru_alloc)
+ * @NL80211_RATE_INFO_320_MHZ_WIDTH: 320 MHz bitrate
+ * @NL80211_RATE_INFO_EHT_MCS: EHT MCS index (u8, 0-15)
+ * @NL80211_RATE_INFO_EHT_NSS: EHT NSS value (u8, 1-8)
+ * @NL80211_RATE_INFO_EHT_GI: EHT guard interval identifier
+ *	(u8, see &enum nl80211_eht_gi)
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
+ *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3340,6 +3624,11 @@ enum nl80211_rate_info {
 	NL80211_RATE_INFO_HE_GI,
 	NL80211_RATE_INFO_HE_DCM,
 	NL80211_RATE_INFO_HE_RU_ALLOC,
+	NL80211_RATE_INFO_320_MHZ_WIDTH,
+	NL80211_RATE_INFO_EHT_MCS,
+	NL80211_RATE_INFO_EHT_NSS,
+	NL80211_RATE_INFO_EHT_GI,
+	NL80211_RATE_INFO_EHT_RU_ALLOC,
 
 	/* keep last */
 	__NL80211_RATE_INFO_AFTER_LAST,
@@ -3650,11 +3939,20 @@ enum nl80211_mpath_info {
  *     capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE: HE PPE thresholds information as
  *     defined in HE capabilities IE
- * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band HE capability attribute currently
- *     defined
  * @NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA: HE 6GHz band capabilities (__le16),
  *	given for all 6 GHz band channels
+ * @NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS: vendor element capabilities that are
+ *	advertised on this band/for this iftype (binary)
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC: EHT MAC capabilities as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY: EHT PHY capabilities as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET: EHT supported NSS/MCS as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE: EHT PPE thresholds information as
+ *	defined in EHT capabilities element
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
+ * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
 enum nl80211_band_iftype_attr {
 	__NL80211_BAND_IFTYPE_ATTR_INVALID,
@@ -3665,6 +3963,11 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
 	NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
+	NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
@@ -3809,6 +4112,10 @@ enum nl80211_wmm_rule {
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
  *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
+ *	as the primary or any of the secondary channels isn't possible
+ * @NL80211_FREQUENCY_ATTR_NO_EHT: EHT operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3845,6 +4152,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_4MHZ,
 	NL80211_FREQUENCY_ATTR_8MHZ,
 	NL80211_FREQUENCY_ATTR_16MHZ,
+	NL80211_FREQUENCY_ATTR_NO_320MHZ,
+	NL80211_FREQUENCY_ATTR_NO_EHT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4043,6 +4352,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
+ * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4061,6 +4371,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
+	NL80211_RRF_NO_320MHZ		= 1<<18,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
@@ -4558,6 +4869,8 @@ enum nl80211_key_mode {
  * @NL80211_CHAN_WIDTH_4: 4 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_8: 8 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_16: 16 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_320: 320 MHz channel, the %NL80211_ATTR_CENTER_FREQ1
+ *	attribute must be provided as well
  */
 enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_20_NOHT,
@@ -4573,6 +4886,7 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_4,
 	NL80211_CHAN_WIDTH_8,
 	NL80211_CHAN_WIDTH_16,
+	NL80211_CHAN_WIDTH_320,
 };
 
 /**
@@ -4644,6 +4958,8 @@ enum nl80211_bss_scan_width {
  *	Contains a nested array of signal strength attributes (u8, dBm),
  *	using the nesting index as the antenna number.
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
+ * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
+ * @NL80211_BSS_MLD_ADDR: MLD address of this BSS if connected to it.
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4669,6 +4985,8 @@ enum nl80211_bss {
 	NL80211_BSS_PARENT_BSSID,
 	NL80211_BSS_CHAIN_SIGNAL,
 	NL80211_BSS_FREQUENCY_OFFSET,
+	NL80211_BSS_MLO_LINK_ID,
+	NL80211_BSS_MLD_ADDR,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
@@ -4887,6 +5205,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
  * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
  * @NL80211_BAND_S1GHZ: around 900MHz, supported by S1G PHYs
+ * @NL80211_BAND_LC: light communication band (placeholder)
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4896,6 +5215,7 @@ enum nl80211_band {
 	NL80211_BAND_60GHZ,
 	NL80211_BAND_6GHZ,
 	NL80211_BAND_S1GHZ,
+	NL80211_BAND_LC,
 
 	NUM_NL80211_BANDS,
 };
@@ -5462,7 +5782,7 @@ enum nl80211_iface_limit_attrs {
  *	=> allows 8 of AP/GO that can have BI gcd >= min gcd
  *
  *	numbers = [ #{STA} <= 2 ], channels = 2, max = 2
- *	=> allows two STAs on different channels
+ *	=> allows two STAs on the same or on different channels
  *
  *	numbers = [ #{STA} <= 1, #{P2P-client,P2P-GO} <= 3 ], max = 4
  *	=> allows a STA plus three P2P interfaces
@@ -5507,7 +5827,7 @@ enum nl80211_if_combination_attrs {
  * @NL80211_PLINK_ESTAB: mesh peer link is established
  * @NL80211_PLINK_HOLDING: mesh peer link is being closed or cancelled
  * @NL80211_PLINK_BLOCKED: all frames transmitted from this mesh
- *	plink are discarded
+ *	plink are discarded, except for authentication frames
  * @NUM_NL80211_PLINK_STATES: number of peer link states
  * @MAX_NL80211_PLINK_STATES: highest numerical value of plink states
  */
@@ -5644,13 +5964,15 @@ enum nl80211_tdls_operation {
 	NL80211_TDLS_DISABLE_LINK,
 };
 
-/*
+/**
  * enum nl80211_ap_sme_features - device-integrated AP features
- * Reserved for future use, no bits are defined in
- * NL80211_ATTR_DEVICE_AP_SME yet.
+ * @NL80211_AP_SME_SA_QUERY_OFFLOAD: SA Query procedures offloaded to driver
+ *	when user space indicates support for SA Query procedures offload during
+ *	"start ap" with %NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT.
+ */
 enum nl80211_ap_sme_features {
+	NL80211_AP_SME_SA_QUERY_OFFLOAD		= 1 << 0,
 };
- */
 
 /**
  * enum nl80211_feature_flags - device/driver features
@@ -5661,7 +5983,7 @@ enum nl80211_ap_sme_features {
  * @NL80211_FEATURE_INACTIVITY_TIMER: This driver takes care of freeing up
  *	the connected inactive stations in AP mode.
  * @NL80211_FEATURE_CELL_BASE_REG_HINTS: This driver has been tested
- *	to work properly to suppport receiving regulatory hints from
+ *	to work properly to support receiving regulatory hints from
  *	cellular base stations.
  * @NL80211_FEATURE_P2P_DEVICE_NEEDS_CHANNEL: (no longer available, only
  *	here to reserve the value for API/ABI compatibility)
@@ -5950,6 +6272,25 @@ enum nl80211_feature_flags {
  *      frame protection for all management frames exchanged during the
  *      negotiation and range measurement procedure.
  *
+ * @NL80211_EXT_FEATURE_BSS_COLOR: The driver supports BSS color collision
+ *	detection and change announcemnts.
+ *
+ * @NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD: Driver running in AP mode supports
+ *	FILS encryption and decryption for (Re)Association Request and Response
+ *	frames. Userspace has to share FILS AAD details to the driver by using
+ *	@NL80211_CMD_SET_FILS_AAD.
+ *
+ * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
+ *	detection.
+ *
+ * @NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE: Device can perform a MAC address
+ *	change without having to bring the underlying network device down
+ *	first. For example, in station mode this can be used to vary the
+ *	origin MAC address prior to a connection to a new AP for privacy
+ *	or other reasons. Note that certain driver specific restrictions
+ *	might apply, e.g. no scans in progress, no offchannel operations
+ *	in progress, and no active connections.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6014,6 +6355,10 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SECURE_LTF,
 	NL80211_EXT_FEATURE_SECURE_RTT,
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
+	NL80211_EXT_FEATURE_BSS_COLOR,
+	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
+	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -6912,6 +7257,9 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK: negotiate for LMR feedback. Only
  *	valid if either %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED or
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR: optional. The BSS color of the
+ *	responder. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6931,6 +7279,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
+	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
@@ -7299,4 +7648,76 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_mbssid_config_attributes - multiple BSSID (MBSSID) and enhanced
+ * multi-BSSID advertisements (EMA) in AP mode.
+ * Kernel uses some of these attributes to advertise driver's support for
+ * MBSSID and EMA.
+ * Remaining attributes should be used by the userspace to configure the
+ * features.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES: Used by the kernel to advertise
+ *	the maximum number of MBSSID interfaces supported by the driver.
+ *	Driver should indicate MBSSID support by setting
+ *	wiphy->mbssid_max_interfaces to a value more than or equal to 2.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY: Used by the kernel
+ *	to advertise the maximum profile periodicity supported by the driver
+ *	if EMA is enabled. Driver should indicate EMA support to the userspace
+ *	by setting wiphy->ema_max_profile_periodicity to
+ *	a non-zero value.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_INDEX: Mandatory parameter to pass the index of
+ *	this BSS (u8) in the multiple BSSID set.
+ *	Value must be set to 0 for the transmitting interface and non-zero for
+ *	all non-transmitting interfaces. The userspace will be responsible
+ *	for using unique indices for the interfaces.
+ *	Range: 0 to wiphy->mbssid_max_interfaces-1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX: Mandatory parameter for
+ *	a non-transmitted profile which provides the interface index (u32) of
+ *	the transmitted profile. The value must match one of the interface
+ *	indices advertised by the kernel. Optional if the interface being set up
+ *	is the transmitting one, however, if provided then the value must match
+ *	the interface index of the same.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_EMA: Flag used to enable EMA AP feature.
+ *	Setting this flag is permitted only if the driver advertises EMA support
+ *	by setting wiphy->ema_max_profile_periodicity to non-zero.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_config_attributes {
+	__NL80211_MBSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+	NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+	NL80211_MBSSID_CONFIG_ATTR_INDEX,
+	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
+	NL80211_MBSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MBSSID_CONFIG_ATTR_LAST,
+	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_ap_settings_flags - AP settings flags
+ *
+ * @NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT: AP supports external
+ *	authentication.
+ * @NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT: Userspace supports SA Query
+ *	procedures offload to driver. If driver advertises
+ *	%NL80211_AP_SME_SA_QUERY_OFFLOAD in AP SME features, userspace shall
+ *	ignore SA Query procedures and validations when this flag is set by
+ *	userspace.
+ */
+enum nl80211_ap_settings_flags {
+	NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT	= 1 << 0,
+	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.34.3

