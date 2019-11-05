Content-Type: multipart/mixed; boundary="===============0127116993864062623=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Fwd: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
Date: Tue, 05 Nov 2019 10:47:53 -0600
Message-ID: <b50d3e7f-760a-79d1-a3a2-83c94bb7c83d@gmail.com>
In-Reply-To: <CAKGWAO9pYgPuq=6JCsjBtSppH3KXD503ovskc5zyAQk9PjGgZg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0127116993864062623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

> This condition appears to have been inverted accidentally :3.
> I noticed because this causes the test to (always) fail.
> Compare to the logic this replaces:
> =


Good eyes! Fixed in 217dc6d4cc7c ("unit: Fixup test-wsc")

Regards,
-Denis
--===============0127116993864062623==--

