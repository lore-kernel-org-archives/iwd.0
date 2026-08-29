Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C97632
	for <iwd@lists.linux.dev>; Sat, 29 Aug 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787980423; cv=none; b=nF6ClBkv5G94pLsuxOau5KCUvSixMpc9H9K0WGuJFLcq5/s9Gssk9SDlAXrmV0xp36LYUxteh3u6hkngec+WMeDmaC9eXQkuFDIV5uif9soMxx//pIiPmr1/nYuwE3qvIzlpds+NEPLYNPawzPEoXz5Ekp2Y7foSubdzPJ/+Xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787980423; c=relaxed/simple;
	bh=K74xWL0m0zEoZGm30hGxBNeniFQexC1MdDhdGzh80Aw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=flQSPUj6OUNDq2p6u/5dwpfxDE0SHSOckMExLwokfPcQXC3+iti4B13EW1JmXlxYrx4hBXE2llstG/WWJLAQ1l6xnZ4yygKyRqOm9CV4Zsti0ZyLbk9/fE87tqD4+ucZ9O9XAtjSmA6Kmc6tuTXwpIDfn3Bl7AI6NCMqsF5a+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=serenium@gmx.com header.b=FJESHhbr; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=serenium@gmx.com header.b="FJESHhbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1787980419; x=1788585219; i=serenium@gmx.com;
	bh=LiUkxytWgBOINQ2IFzyE5uNDYtpwODm75Uk28RWim2o=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FJESHhbrDebIm/Un1FpUhHtXa7g7MNRGgdj39Y+hkQQdp7G1coDZqc3KYx3YQP1l
	 aUT7xaxWFUPQDJbBW6nUAzgjHwnPjMBY4IxZQ/A1jd5mfZLv3hP5xg+gh05/Znldm
	 b5wv/83VZQsYlZOQUBouHjTzuxfGy0pilB4NoswbbKLIElOXobVUTj6gwtaonpXPg
	 6qsnyLmWiXJrof3pE35UXz1zlIozPrcA5llw+pyTfNGolph0B8UQenu0m37ceARmI
	 qgURac3p28eWjSjIfseqxxxPe2eQq1Hw5x2bK+NxngchyvIkQjfPe7PCFzR+ApqWc
	 Dayj3JCWnMTXV43lnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MulqD-1wiNNp2VM3-00xkgf for
 <iwd@lists.linux.dev>; Sat, 29 Aug 2026 07:13:39 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Aug 2026 15:13:35 +1000
Message-Id: <DL165RCXD4PO.1EH5BPELX2Y1Q@gmx.com>
Subject: [PATCH] ap: pass HT and WME station capabilities
From: "Serenium" <serenium@gmx.com>
To: <iwd@lists.linux.dev>
X-Mailer: aerc 0.22.0
X-Provags-ID: V03:K1:iIKytQiNn4SMCtWPq5VwpQuxTVhFNWpR/rF8y7MOYGgtBo/Tcb9
 F/2vJkF7E7mHlxD+hgx2OrpDl/Z3AcaMFmlcE5sqiFtR0ECk8t2N37br5Rq3nNeZmlftTVS
 pEMp3KGzPxoX8lKxBZ+ph7gWtfxP2/UxhnYEtHQTdqUoA9K7qLYWmQAm8DenAF+rYh8tgqt
 8673lh770P5/gvkX5rsKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AIeK9Lxr/rg=;uKmKsAYoceZKV3DtqGi3kft5Cgk
 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
 sl03e6fg==

Greetings,

iwd 3.12 and current upstream master silently install HT/WMM-capable AP cli=
ents into mac80211 as legacy, non-WME stations.

This was reproduced on Intel's own AX200 hardware.

Test system:

* iwd 3.12
* Intel AX200
* Linux 7.1.5
* Alpine Linux Edge
* channel 6, 2437 MHz
* 40 MHz AP channel width
* three independently associated clients

Before this patch, every client reported:

```
WMM/WME: no
tx bitrate: 5.5 MBit/s
```

or:

```
WMM/WME: no
tx bitrate: 11.0 MBit/s
```

Measured transfer performance was approximately 788 kB/s.

This is not a driver capability, regulatory-domain, beacon-generation, or c=
lient problem.

An iwmon netlink PCAP proves that:

1. iwd correctly parses the AX200's 2.4 GHz HT40 capabilities.

2. iwd's probe response contains HT Capabilities, HT Operation, and a WMM P=
arameter IE.

3. The client association request contains a valid 26-byte HT Capability IE=
.

4. The client association request contains a valid WMM Information IE:

   ```
   dd 07 00 50 f2 02 00 01 00
   ```

5. iwd's association response contains HT Capabilities, HT Operation, and W=
MM.

The failure occurs when iwd constructs NL80211_CMD_NEW_STATION.

The existing AP code retains only a Boolean indication that the station sup=
ports HT. It discards the station's actual HT Capability element, does not =
parse its WMM Information element, and does not provide the corresponding s=
tation state to mac80211.

Specifically, it omits:

* NL80211_ATTR_HT_CAPABILITY
* nested NL80211_ATTR_STA_WME
* NL80211_STA_FLAG_WME in NL80211_ATTR_STA_FLAGS2

The missing WME station flag is decisive. Without it, mac80211 records the =
station as non-WME and does not enable HT operation.

After applying the patch below, all three clients report:

```
WMM/WME: yes
tx bitrate: 26.0 MBit/s MCS 3
```

MCS varies normally under rate control.

The same 256 MiB transfer test then produced:

```
268435456 bytes copied, 21.5456 s, 12.5 MB/s
```

That is approximately 100 Mbit/s and around sixteen times the previous meas=
ured throughput.

The patched daemon has been built, packaged as iwd-3.12-r1, installed under=
 normal OpenRC management, and verified with three simultaneous clients.

The defect is also present on current upstream master. There are no post-3.=
12 src/ap.c commits addressing it, and current master does not use NL80211_=
ATTR_HT_CAPABILITY or NL80211_ATTR_STA_WME in the AP station-install path.

Patch follows.

---

src/ap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
1 file changed, 45 insertions(+)

diff --git a/src/ap.c b/src/ap.c
--- a/src/ap.c
+++ b/src/ap.c
@@ -127,6 +127,9 @@ struct sta_state {
bool rsna;
uint16_t aid;
struct mmpdu_field_capability capability;

* uint8_t ht_capabilities[26];
* uint8_t wmm_uapsd_queues;
* uint8_t wmm_max_sp;
  uint16_t listen_interval;
  struct l_uintset *rates;
  uint32_t assoc_resp_cmd_id;
  @@ -147,6 +150,7 @@ struct sta_state {

  bool ht_support : 1;
  bool ht_greenfield : 1;
* bool wmm_support : 1;
  };

struct ap_wsc_pbc_probe_record {
@@ -1683,6 +1687,11 @@ static struct l_genl_msg *ap_build_cmd_new_station(s=
truct sta_state *sta)
NL80211_STA_FLAG_AUTHENTICATED);

* if (sta->wmm_support) {

* ```
    flags.mask |=3D 1 << NL80211_STA_FLAG_WME;
  ```

* ```
    flags.set |=3D 1 << NL80211_STA_FLAG_WME;
  ```

* }

* msg =3D l_genl_msg_new_sized(NL80211_CMD_NEW_STATION, 300);

  l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
  @@ -1835,6 +1844,21 @@ static void ap_associate_sta(struct ap_state *ap, =
struct sta_state *sta)
  rates[count++] =3D r;

  l_genl_msg_append_attr(msg, NL80211_ATTR_STA_AID, 2, &sta->aid);

*

* if (sta->ht_support)

* ```
    l_genl_msg_append_attr(msg, NL80211_ATTR_HT_CAPABILITY,
  ```

* ```
    			sizeof(sta->ht_capabilities),
  ```

* ```
    			sta->ht_capabilities);
  ```

*

* if (sta->wmm_support) {

* ```
    l_genl_msg_enter_nested(msg, NL80211_ATTR_STA_WME);
  ```

* ```
    l_genl_msg_append_attr(msg,
  ```

* ```
    			NL80211_STA_WME_UAPSD_QUEUES, 1,
  ```

* ```
    			&sta->wmm_uapsd_queues);
  ```

* ```
    l_genl_msg_append_attr(msg, NL80211_STA_WME_MAX_SP, 1,
  ```

* ```
    			&sta->wmm_max_sp);
  ```

* ```
    l_genl_msg_leave_nested(msg);
  ```

* }

* l_genl_msg_append_attr(msg, NL80211_ATTR_STA_SUPPORTED_RATES,
  count, &rates);
  l_genl_msg_append_attr(msg, NL80211_ATTR_STA_LISTEN_INTERVAL, 2,
  @@ -2173,7 +2197,28 @@ static void ap_assoc_reassoc(struct sta_state *sta=
, bool reassoc,
  if (test_bit(ie_tlv_iter_get_data(&iter), 4))
  sta->ht_greenfield =3D true;

* ```
    	memcpy(sta->ht_capabilities,
  ```

* ```
    			ie_tlv_iter_get_data(&iter),
  ```

* ```
    			sizeof(sta->ht_capabilities));
    	sta->ht_support =3D true;
    	break;
  ```

* ```
    case IE_TYPE_VENDOR_SPECIFIC: {
  ```

* ```
    	const uint8_t *vendor =3D
  ```

* ```
    			ie_tlv_iter_get_data(&iter);
  ```

* ```
    	uint8_t qos_info;
  ```

*

* ```
    	if (ie_tlv_iter_get_length(&iter) !=3D 7 ||
  ```

* ```
    			memcmp(vendor, microsoft_oui, 3) ||
  ```

* ```
    			vendor[3] !=3D 2 ||
  ```

* ```
    			vendor[4] !=3D 0 ||
  ```

* ```
    			vendor[5] !=3D 1)
  ```

* ```
    		break;
  ```

*

* ```
    	qos_info =3D vendor[6];
  ```

* ```
    	sta->wmm_uapsd_queues =3D qos_info & 0x0f;
  ```

* ```
    	sta->wmm_max_sp =3D (qos_info >> 5) & 0x03;
  ```

* ```
    	sta->wmm_support =3D true;
  ```

* ```
    	break;
  ```

* ```
    }
    }
  ```

  }

Tested-by: Saarin <serenium@gmx.com>

## Independent engineering statement

Defect isolation, source tracing, netlink capture, patch development,
Alpine packaging, deployment, and performance validation consumed
approximately three days of independent, unpaid engineering work.

Compensation provided by Intel: AUD $0.00

Mock invoice:

```
Client: Intel / iwd project
Service: Completion of AP HT/WME station installation
Hardware: Intel AX200
Investigation: 3 days
Demonstrated performance recovery: approximately 16x
Amount paid: AUD $0.00
Balance: one conspicuously unfinished AP code path
```

If Intel does not compensate independent users who complete and validate
its wireless stack, an appropriate alternative would be a public donation
to Alpine Linux or another community Linux project, accompanied by a
receipt to this list.

The technical evidence, before/after station dumps, signed Alpine package,
packaging commit, and full iwmon PCAP are available.

Regards,

Saarin

