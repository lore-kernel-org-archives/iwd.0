Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D12F22
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 16:54:30 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A2EEF320091D
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 11:54:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Dec 2022 11:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1670864069; x=1670950469; bh=C6+cNFq4NR
	aoAcCg55g8kT8F1iOS2H/5opgiCZHysUk=; b=X4l+sX0G3tkbk/Estn6/cFSoVt
	TAcbIiPKU6AqlyD1vNsQ4Pn7fo/Nazwv5j177ir3jDxxKkiB3BTSXnkOj1VA6I7X
	iB3jev/5xCgZR9yux86s6+8x40n4SaBCN2UvBTcT/opc/ezILuuJNlGGUQzdMkk/
	eE+nNhJnvl3/cztC5clKei+ad02/tmctU+XuQEOgouBZLxsc0rb/8ENVRZvl2bRg
	nDjvScZXLgYHdsuytBAQvvv0g1PcG+FOnHwOtMWiQaI4DBVY0IVoxxzQbUJoFoBT
	rIRSjGK06ykYSWoHraoGeGKNCkmRozrXWhv4BlEMCrOoX+9RPVdPL48ovWSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1670864069; x=1670950469; bh=C6+cNFq4NRaoAcCg55g8kT8F1iOS
	2H/5opgiCZHysUk=; b=GoGfo21GFuzTjd/fPsx8Y4cr+Ba8ta1zm6cGsEj5Q8vR
	Xi6NZMbDWoExJgHNdjl+uDh5wuRJoYALpM5Ja95AIaCSZSLnEbZzD53NI8v1gs+M
	Y7sLfRe2+TlWRdLTYv0hmp7UhHYXRFRY0jfmi45RExsFhpMKykSDA4MBAzU+HJEC
	UkgGqZThNcP7FmyZD9+eqn9UVzfoj62vqFlsOUNRIpK1wdUgQsnQQYvzqrTEPLCO
	pPawtda7vFQvzFR8pOYvuipsZkPOFlg7uMVE9jmoNsKlm0ey0KhayDwuW3vlN8lD
	0Em7BfwcRjQuh+KcqK7By++G1vr3QxuoaAWgn2B3OA==
X-ME-Sender: <xms:xVyXYzIE8CVIpH68WnDlYtAeAj5t0IgKWLl3UOUXs5ke2dPl6OH5pA>
    <xme:xVyXY3LRBE3eRIZYD7dmnGyf7T4JJI6NLO2zKQoM82ZYjSmobbm32Gk4Y3VK-E48m
    NB8n74hQGdrxvKi>
X-ME-Received: <xmr:xVyXY7vxsQdgHldEp0f_8KQ-h33jcTNgp_9CAQxv1mYDEcfm5daUFnyCKmQg8tiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthejredttd
    efjeenucfhrhhomhepuehruhhnohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphho
    shhtrdhnvghtqeenucggtffrrghtthgvrhhnpeeujeetudeiteetkeeivdfffeetfedtve
    egheelffejudegffduhfeggeekfeelueenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegurghnthgrshesrghirhhpohhsthdrnhgvth
X-ME-Proxy: <xmx:xVyXY8ZaOW1vA-m1NRrdQDujGcEUyagIGeid0TfAxxYiOTkMTj_dFA>
    <xmx:xVyXY6ZOxafecVNOWHQKWrlrIz6thKIAkinOFbw_6D5OkG_GzQZmNg>
    <xmx:xVyXYwA9mqnHCrxqV6OMpQow06-srDxrBipOX5l5gXmgJ1uREdz0VA>
    <xmx:xVyXY40A824XCt5kC7z5-Gd18_yJ9VfIIuPrIpclHtluEX3DVOmoWg>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <iwd@lists.linux.dev>; Mon, 12 Dec 2022 11:54:28 -0500 (EST)
To: iwd@lists.linux.dev
From: Bruno Dantas <dantas@airpost.net>
Subject: iwd release 1.30 onwards cannot find available networks
Message-ID: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
Date: Mon, 12 Dec 2022 11:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I was a happy iwd user through release 1.29. From 1.30 onwards (including the latest version 2.0) I had to switch to wpa_supplicant because in most (but, strangely, not all) locations where I go, iwd fails to find any available networks ("sudo iwctl station wlan0 get-networks" says "No networks available").

Today I finally got around to doing a git bisect to pinpoint the regression. The bisect concluded with this:

dfcba7c83c60f1a99ecf6f1424e97bf89fcab38e is the first bad commit
commit dfcba7c83c60f1a99ecf6f1424e97bf89fcab38e
Author: James Prestwood <prestwoj@gmail.com>
Date:   Thu Aug 4 11:51:06 2022 -0700

    wiphy: track GET_REG ID
    
    Keep track of the GET_REG call so it can be canceled if the wiphy
    goes down.

 src/wiphy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

In case it's helpful, my machine is an X230 ThinkPad with coreboot, linux kernel version 5.15.10, running Tiny Core Linux 13.1 x86_64. My wireless card is Intel Dual Band Wireless-AC 7265. If you guys need any more information, I'd love to help.

Please fix this regression if possible. I'd love to go back to using iwd in the future.

Happy hacking!
Bruno "GNUser" Dantas

 
