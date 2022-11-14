Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFA6FC1
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 16:24:35 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4N9vd42w2Hz9sTF
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:18:48 +0100 (CET)
Message-ID: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
Date: Mon, 14 Nov 2022 17:18:46 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: en-US
To: iwd@lists.linux.dev
From: =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Subject: Scanning hangs up with Marvell wifi card
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

iwd is having trouble scanning for me, it seems that any subsequent scan after
the first one never finishes. A quick round of debugging tells it's worked
around by adding at least 100ms of sleep before queuing the second scan with
station_dbus_scan_subset() here:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n3886

I'm using a Marvell wifi card with fullmac driver that is known to have a ton of
issues, so I'm assuming it doesn't like seeing scan requests very quickly after
finishing a scan?

Fwiw, when the second scan is started, the last entry in debug logs is this, so I
guess the last thing we do is really queuing the new scan:

src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2

Cheers,
Jonas
