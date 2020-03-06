Content-Type: multipart/mixed; boundary="===============6069490302653127317=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] iwd: define a maximum passphrase length
Date: Fri, 06 Mar 2020 12:20:05 -0600
Message-ID: <026008b3-3eed-399b-ab03-dc9cafed5803@gmail.com>
In-Reply-To: <d0d5e711d0af0dcef2c60c395b21f049d67defee.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6069490302653127317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> +#define IWD_MAX_PASSPHRASE_LEN	2048
> =

> Tim pointed out this should really be called IWD_MAX_PASSWORD_LEN since
> 'PASSPHRASE' implies a WPA passphrase which does have a defined maximum
> length of 63 characters. This value is only meant for EAP method
> passwords that have no defined maximum.

Yes, password would be better.

Regards,
-Denis
--===============6069490302653127317==--

