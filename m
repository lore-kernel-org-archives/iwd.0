Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17423A7
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:33:48 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id u5so4608023pjy.5
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eR5bfOTY2z+n3x1iw5yyh08igFT3hbkOI4HKxs22IZI=;
        b=U98NTbfuFK60bmJ/88W9t1Fq8Msu+n1XBWxkKcgszK+UVvss9QajXj3xLl76HZW7L2
         m0UK3oWnV2h2ZCHfbWdJsEwrupvWQ7r2f3UymHyx/KdFKbTvIeK6JkioFmboH9W0Ssps
         XdbtMdN7fUDxo/G+EMIW5qTQL7HAnoBWM3a7p4MBZZd8uegj0S2qh0RUWR8H62xm+/nf
         JZHJTerymvCtYaYne3XqP4l+h9vvz45OGrDl2qwUIKU5YsCsTTPMHGk5lCuuPSYpWIWV
         VldDSGkrpiZ/WTid1mJdD4aYZ/yWkOR8TOTvq8hPKrep9xDysp5YTtrHJJrjGb9va+6c
         jPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eR5bfOTY2z+n3x1iw5yyh08igFT3hbkOI4HKxs22IZI=;
        b=oGDdmDbza614KtQafzWxvDfZF1HHGduI+brgFKJrdJ7i+t93ADzvyOF4/gn7olpC51
         PmJGP23LFL+Mx3AA4AzeD/uh/MJwuCz4HiSdp/zRWfCklSG93DZe6HFam3ewM45QxqJW
         plqoT74zyJHUzekTUuUxsMED/GLp2AqEZmdxWDJnBrqwBAoTXnaXjMdeB8xBBST5M30c
         G//KLe/DevjgAX7gEaBediu101SbZQ3Kc35uDodladKxjdkclrSBhNeVjKPVAo1J7vlA
         RJg0rvFvRTQpF/W9erIOc65kGUG9DVek9I56JWxj440mMOtwKIosReZuV8DjLRnLee/o
         r7PQ==
X-Gm-Message-State: ANoB5pnIyFUAYIfxWW5BiCGliTHQPwPV+q5zm3T0R2ygtt0hAFJeodtt
	1ieOwEJe+dZwJFeIxjUOY7s6jokeWPI=
X-Google-Smtp-Source: AA0mqf7T/01qnBYT60CJdn23ltaslmfd1BxGXFu82TLkyw8qm/I7aW/kcLRzoKF8o4t5ZYO7rBa3Ow==
X-Received: by 2002:a17:90a:b891:b0:21d:5e73:d562 with SMTP id o17-20020a17090ab89100b0021d5e73d562mr20723042pjr.27.1670963628308;
        Tue, 13 Dec 2022 12:33:48 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a088200b0021952b5e9bcsm7476996pjc.53.2022.12.13.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:33:47 -0800 (PST)
Message-ID: <88c5f15eae4004d50f9862892c44156e813c4656.camel@gmail.com>
Subject: Re: iwd release 1.30 onwards cannot find available networks
From: James Prestwood <prestwoj@gmail.com>
To: Bruno Dantas <dantas@airpost.net>, Alvin =?UTF-8?Q?=C5=A0ipraga?=
	 <ALSI@bang-olufsen.dk>
Cc: Denis Kenzior <denkenz@gmail.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Tue, 13 Dec 2022 12:33:47 -0800
In-Reply-To: <8705db73-b6e8-eea4-d2fd-271d1501c52d@airpost.net>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
	 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
	 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
	 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
	 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
	 <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
	 <615ceb63-e041-1990-81fa-568181681aa7@airpost.net>
	 <59639a626260a24147be730f9703e0d766bd5f1b.camel@gmail.com>
	 <8705db73-b6e8-eea4-d2fd-271d1501c52d@airpost.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Bruno,

On Tue, 2022-12-13 at 15:15 -0500, Bruno Dantas wrote:
> Hi, James.
> 
> > Maybe you missed Denis' email, but I've sent a patch that will
> > hopefully fix your problem. Its on the list, or archives:
> > 
> > https://lore.kernel.org/iwd/20221212220857.1284874-1-prestwoj@gmail.com/T/#u
> 
> Oops. Sorry for missing that. Yes, I applied your patch and can
> confirm that it fixed the problem I was experiencing! Thank you so
> much. I'm much obliged.
> 
> Will your patch be included in the next release of iwd?
> 
> -Bruno
> 
> P.S. Just curious--what are your thoughts on why this bug would
> consistently affect me in one place (at hospital where I work) and
> consistently _not_ affect me in another (at home)? I'm at a loss.

Great! Glad it fixed it.

The issue itself was because the regulatory domain was updating during
a scan which we added logic to support but it wasn't quite correct.

Probably was happening at work because there were enough APs around
that included the country IE. So the kernel/firmware sees this and sets
the regulatory domain to that country. And at home there was not enough
enough APs around, or they didn't include that IE so the regdom never
changed.

Thanks,
James

