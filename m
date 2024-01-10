Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF44C3B9
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id CB48DCECC4;
	Wed, 10 Jan 2024 18:05:17 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] Log falling back from SAE to WPA2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <44da90d8-88c4-4a92-9114-0ed875e86cc7@gmail.com>
Date: Wed, 10 Jan 2024 18:05:07 +0100
Cc: Fiona Klute <fiona.klute@gmx.de>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C50971A2-BFDF-4A5B-9027-FC32462AFB88@holtmann.org>
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
 <BD87F517-7D4C-48AA-BB73-D18C9AE6322C@holtmann.org>
 <44da90d8-88c4-4a92-9114-0ed875e86cc7@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Denis,

>>>> I've had connections to a WPA3-Personal only network fail with no =
log
>>>> message from iwd, and eventually figured out to was because the =
driver
>>>> would've required using CMD_EXTERNAL_AUTH. With the added log =
messages
>>>> the reason becomes obvious.
>>>=20
>>> Interesting.  Last time I checked only the quantenna driver used =
this feature and it wasn't very common.  If it isn't a secret, what card =
/ driver do you have?
>> according to Arend on an email thread with the Apple WiFi support, he =
hinted that Broadcom with their devices/firmware opted for the =
CMD_EXTERNAL_AUTH option while the Cypress/Infineon devices with their =
firmware (like Raspberry Pi) are using the SAE offload feature.
>=20
> Yeah I saw that as well.  I don't have any Cypress devices.  AFAIK =
Raspberry Pi uses brcmfmac + firmware that supports SAE authentication =
in CMD_CONNECT, not CMD_EXTERNAL_AUTH.  Someone who knows better please =
correct me.

I got the impression that Apple M1/M2/M3 Macs (or even their Intel Macs) =
would be using CMD_EXTERNAL_AUTH, but details are unclear. Does =
wpa_supplicant actually supports it?

Regards

Marcel

