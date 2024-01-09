Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E331A7E
	for <iwd@lists.linux.dev>; Tue,  9 Jan 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="boZSa6ge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704794396; x=1705399196; i=fiona.klute@gmx.de;
	bh=nMAvoUVDdvbHz604jOoi6F4LTbleTuKMrAwKUf4VyhM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=boZSa6geBCsaSdPkScDQxImqkJQYQNAPln1qDzAunvUq/OcxWPaqeW9qs/BQrojv
	 Dwk1sJBuWCUZ0wjeCeqNYQh/+uzGS1b8Tv24ymVuBWgNSt9A+UT/z4zOBX4oNeUfo
	 YTdu/j/9xvfyko+80QhzoF1ecFn1d+0oM90bs+kbj6Yt0Iz1Ru0BL/CLn3HFTvwkz
	 eZXXyaChypm4XujKGRgbcoP6OGWupfHrxr7wY8g+/sLPh8RtGw6EtGSnVQth7jm0R
	 o1AJW+EiWc4hxFAvKtVQ3eYuU+EI3DkqAG3yhwIIdpw331UBAHN9yPYnCF/548xjx
	 VPCGMx6faTT+TfZH0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.30.38]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1rHuEV19Wx-006Q97; Tue, 09
 Jan 2024 10:59:56 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: iwd@lists.linux.dev
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH] Log falling back from SAE to WPA2
Date: Tue,  9 Jan 2024 10:59:26 +0100
Message-ID: <20240109095926.1541238-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ps3UzIONO/fkGv21UDtvkhjU7bYMe5FAaapzS937h5F9T42cGMP
 bfXE4WmHuQqMcYXHM1Ayagq1pkdW0WTJhuYKNTdt9KCKrhyfwbYyG6nKnI9wksNSs0TvPnc
 w90MMqr1HBNHAnvXPEXC0r39xIE08TB93HGP4HzHTXQM4gROgspJjSCoyiVD041CIZjiTMm
 ZYFk5YOH3shMQXr6u2oWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IwI0ikyA68A=;LO+N+4GQj06m0caYRyu6hlJz2Tt
 fedfzR1IyQnhjktwG7M1WCKeoGhIT+7jyyxZO2HhXPlXMKHmGl5h3Wx5Fzt34pqvUvZPRk95X
 rn+RXsliRvumNqCb8jrOtUyQPLTnbqdHeBu+d3AApNp2P433X6EqfYe5Li6fttTBNi4LnGxza
 1i3ZGvRTa/grTVL67qvSbxSUFcA4USXTk5W9kE7C3ED4HP4orgS+fJBd8EIfrV03hmkfHsDFJ
 uhyhrNmzZ/7jw0+qiba+cwYn1PvwuZz9lIb8d7oTDDNlMqsKle8oK1wrmyEtI8HldNbp6u9mw
 X2/sK2/OEmiqCHYXqkYbN7txhvddBaxv6EtCLd4CIAx/HgO3k8fsT5y7YdqrRWNnJtjwpaaO/
 tNGexsvWdVM1MbeJPNJw0MfnMK3vkgrHBGLaHU5dB9c4S/q07BG21QDGTv1xKA2tg0Lg56w49
 wv1r85wNsxNgjZm8iZjhPD9Wldm6wGozyfHyeeKZE7bDD6tMTrLWB5BS93nUGtVHY+7cLF61I
 G6hVzzXei5JlmOTSJB7qljdkeQwyzaFJOD2UgsBsUvXgAX2VCwLh0zoAzDfKfOxTGAeXZmoDH
 N317Hy0pXBUYpuIUIs0JPYVKBQtNFRafknWUv9IuZ04L4Dvkj6K2qL9/IQwB+FXXMVikMT3jG
 erQue8rVjgNueeSx91YZhSLymgqHpeDwo2wEzkdvCloOW7cvRntgBCyWDqutT+J8lpVFtSfzz
 r1K0/sYL1vKXCIRi2aB9OZYVUrVS+lwvyhsVhBpW5WqJJVspvSe2oQKowwfnZh/yzWdhdsR9h
 +XSh3fuYmX/XLWAmCQX/KozaGHiiNK0aGnUtsriQ28fu9bci6ESK7JBMrvMhY+3/fC2dzUk2p
 UFt1aavY4qODlbxS6BB1mKUwNyEt8UaF0iyFeU+GzwNx2YEt4QyG9WrEHIpUJLt5NkTDelAVS
 mShc0Q==

I've had connections to a WPA3-Personal only network fail with no log
message from iwd, and eventually figured out to was because the driver
would've required using CMD_EXTERNAL_AUTH. With the added log messages
the reason becomes obvious.

Additionally the fallback may happen even if the user explicitly
configured WPA3 in NetworkManager, I believe a warning is appropriate
there.
=2D--
 src/wiphy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 766df348..5530e9c6 100644
=2D-- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -248,6 +248,8 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 		 *
 		 * TODO: No support for CMD_EXTERNAL_AUTH yet.
 		 */
+		l_debug("Unsupported: %s needs CMD_EXTERNAL_AUTH for SAE",
+			wiphy->driver_str);
 		return false;
 	}

@@ -312,8 +314,10 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
 		if (ie_rsne_is_wpa3_personal(info)) {
 			l_debug("Network is WPA3-Personal...");

-			if (!wiphy_can_connect_sae(wiphy))
+			if (!wiphy_can_connect_sae(wiphy)) {
+				l_warn("Can't use SAE, trying WPA-2");
 				goto wpa2_personal;
+			}

 			if (info->akm_suites &
 					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
=2D-
2.43.0

