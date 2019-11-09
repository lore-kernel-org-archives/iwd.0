Content-Type: multipart/mixed; boundary="===============5137814107157995475=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Fri, 08 Nov 2019 21:33:48 -0600
Message-ID: <98fc86c6-65dd-0ddc-513c-9b30401d1644@gmail.com>
In-Reply-To: <50E8BFFC-2EF8-4E46-A7A7-C8BCE2CA7512@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5137814107157995475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> =

> ok then, fair point. Can we somehow improve these cases with a comment to=
 ease reading and understanding the code.

So something like:

+                *
+                * wiphy should have parsed the supported rates from the
+                * kernel / driver.  If not, warn and give up

Or do you have something else in mind?

Regards,
-Denis
--===============5137814107157995475==--

