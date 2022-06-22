Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302EF1860
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:39:16 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id w3-20020a4ab6c3000000b0041c1e737283so3417158ooo.12
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2/Atd7okF/ehnRTqzBt3CsFJUeFEEYZdeBHEos4Hmuw=;
        b=kJIhlVnItNg0G238XYHi+AMY3uN8S5HycBQc1/BC0HSG2iVH45EU8xt4xUrM69UtWW
         WD7N7XvMaSMIu4a91bRn8DnDp8mY7MDI0D8rtEZKYJL9AEmoKmLw20qZcp76oaJ9e6oc
         uDsU1Y47TMh46AbU74OXvUg0ZKRyiBWrevIz+eCoiNNx5GHcv57sYybFWYsXNCetJsY0
         ofWHbdnBpCTIWPjsuLCWRUhREkoCGftSDmknDu0D/KOuD8X7dGvtLw7VCYs/iZF9k0G0
         Rub8hQuM00dpSHnenfp9w+ctGHVACUNr6fUX5uvomwvm6GJKdBcdNdjnITacf+bcCk4b
         J/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2/Atd7okF/ehnRTqzBt3CsFJUeFEEYZdeBHEos4Hmuw=;
        b=ULpRkKXotbqoKxCWdwyC3VFnE1CsJg8GCIkYhc0EnAZAdcyHyhUQFCzD/68pj3C+aG
         05HfYzR2Rs7GstmbkBohQMcQ69XhnTrcRNToCnYMigKbcyTl4l349xSiys9OsxF/57TP
         W3pjlO416q6Tr+lHia26vSqNJj/cKz5CAAFjHu+xWmwghde8WfBNbRYGRauICcK1umT7
         +Lni5Jp8q7lLm00P83D4/daXBGXmkpH0/YDdMWKMGcGt4dOxVxAIw/bmrXC7pQrtKpJs
         0/j306UW8c0/Aa+H6SfXpfz+yNDrN3GGcBd+AdMmmdGtg52QifBoHvpmrcjPocKh9UEZ
         pMlw==
X-Gm-Message-State: AJIora+icEfJTAzzPXnRUdePWV4UBA9f1OWvAOTcia/P6X9ZwIOyCG3z
	bTHznZ+sd0wjKZbd0GuQJxPYgaxT6HGLze+VU4/e9yY+fIpc4Q==
X-Google-Smtp-Source: AGRyM1vhBhOFajzdY+R4bXewIaZcUYsvdeonmwTzkz/xQTgsJyOu3q5Bs1up4PVWKA4Q/UV7XjmR4dYlq8fbrAW9igo=
X-Received: by 2002:a4a:e787:0:b0:41b:7367:3587 with SMTP id
 x7-20020a4ae787000000b0041b73673587mr1734795oov.11.1655915954948; Wed, 22 Jun
 2022 09:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Date: Wed, 22 Jun 2022 17:39:04 +0100
Message-ID: <CACsRnHX4-Y93QsHz4W+gF7SkOV9u+snNiaDZv=8BOZ4Yz0YBcg@mail.gmail.com>
Subject: Multiple IP addresses after failed roam
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

I have just encountered a client which ended up with two IP addresses
on the wlan and I think it might be related to iwd.
(Un)fortunately it is a rare occurrence so I can't get DHCP debug logs
but I did have the general iwd logging enabled. Hopefully this is
enough to be useful but if not I figured it was worth reporting
anyway.

Basically, at some point the client was disconnected during a roam
with the reason code "UNSPECIFIED". After this `iwd` immediately tries
to reconnect but is refused a couple of times before succeeding.
When it does succeed, the DHCP server attempts to give it the same
address but the ping gets a return and so it assumes it is already in
use. This is likely the client in question as no other client has been
given the IP.
The DHCP server then assigns a new IP and iwd reports it however the
client from this point has both the old and new IP addresses assigned
to the interface.

The "full" logs are here:
https://pastebin.com/YQPnTBKH

This was on version 1.21 + select patches applied (I didn't have time
to validate the latest version unfortunately).

Please let me know if I can help with this. I'm looking through the
code to see if I can see anything but I assume you guys will have a
much better idea where to look.

Regards,
Michael Johnson
