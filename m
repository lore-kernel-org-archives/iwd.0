Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC465747F
	for <iwd@lists.linux.dev>; Wed,  3 May 2023 10:15:47 +0000 (UTC)
Received: from smtpclient.apple (p4fefc45b.dip0.t-ipconnect.de [79.239.196.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 0328FCECE8;
	Wed,  3 May 2023 12:07:06 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4fb2f58e-8a05-93fa-de19-d61d9b4320ed@gmail.com>
Date: Wed, 3 May 2023 12:07:06 +0200
Cc: daniel antoine <univac55@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD529D19-3091-44FA-8AFE-BE89445D9B13@holtmann.org>
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
 <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
 <914A101F-70E4-4FA0-80A9-CF3A28BE61D2@holtmann.org>
 <b2be8a34-3624-b269-e253-6b76373807e0@gmail.com>
 <CA+iibzAW33xScrgXCqMebr1t5AmpPG6xntsv+8z4cUjc8ih4uQ@mail.gmail.com>
 <CA+iibzB2XA6xuQtMQRH3vcPiRtsb5bdDHRDQN5HNbvu2eQttJA@mail.gmail.com>
 <CA+iibzCNBhsS3sCkuN4cdvWmLDokaVMoVS6r8Q2mcKKx1+mm-g@mail.gmail.com>
 <4fb2f58e-8a05-93fa-de19-d61d9b4320ed@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi James,

>> I have updated libedit to 20221030-3.1 et the compilation off iwd is =
OK now
>> may be you have to specify that the level of libedit must be
>> 20221030-3.1 to build with libedit instead of readline
>> I am sorry for the convenience the problem was on my side I was not =
at
>> the last level of libeditt
>=20
> No problem, I ran into the same thing :) Marcel, is there a way to do =
a version check on libedit so configure can detect these unsupported =
versions?

I can check for version >=3D 3.1 when looking for libedit. Is that =
enough?

Regards

Marcel

