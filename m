Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63648482F2
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1E6F1CECC4;
	Wed, 10 Jan 2024 14:12:50 +0100 (CET)
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
In-Reply-To: <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
Date: Wed, 10 Jan 2024 14:12:39 +0100
Cc: Fiona Klute <fiona.klute@gmx.de>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD87F517-7D4C-48AA-BB73-D18C9AE6322C@holtmann.org>
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Denis,

>> I've had connections to a WPA3-Personal only network fail with no log
>> message from iwd, and eventually figured out to was because the =
driver
>> would've required using CMD_EXTERNAL_AUTH. With the added log =
messages
>> the reason becomes obvious.
>=20
> Interesting.  Last time I checked only the quantenna driver used this =
feature and it wasn't very common.  If it isn't a secret, what card / =
driver do you have?

according to Arend on an email thread with the Apple WiFi support, he =
hinted that Broadcom with their devices/firmware opted for the =
CMD_EXTERNAL_AUTH option while the Cypress/Infineon devices with their =
firmware (like Raspberry Pi) are using the SAE offload feature.

So maybe it is time to implement support for CMD_EXTERNAL_AUTH.

Regards

Marcel

