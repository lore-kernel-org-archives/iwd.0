Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE7848B
	for <iwd@lists.linux.dev>; Fri, 26 May 2023 15:03:17 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b0236ee816so95695ad.1
        for <iwd@lists.linux.dev>; Fri, 26 May 2023 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685113397; x=1687705397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XLUvwqoFR+iPaHKf98vXAguPH8z9rZiKt0ifKnK1cmM=;
        b=NYSTNWkkFxm4W4YRkmb7GlUCRmxBk3Ai46xaYGhD6mXYRiZ1wXJpc2ZSMe6gQDm8UC
         YpU8uDbxY8uxe5H8Ku0bPX0alDgtdm730KUm3d8mYohUAF2wlQHnlHPZbqbdUbOuAXcN
         hE/o6O8b3k+kihJSYEMqz/13CAWcjubLCMxN8+wOMxmh5i639NbpmyI+J9D7jtMhKnHP
         NzAX3MqaRS31C+7cnctJpUMC2DvKQO2BqD/eDtrj0vzry0kS5bAOioX1MUzmVvdk0V/u
         iE4xYrqUmnionb24qXpJOjMiMjxb9xm+NYY7sL4ndU5oL/Ej8WfWEvAxnRtpxIMrykH2
         NnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113397; x=1687705397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLUvwqoFR+iPaHKf98vXAguPH8z9rZiKt0ifKnK1cmM=;
        b=SXEFNqfi7LVnti9Vi4/tCt1M/Ww1e+CIcNUxGHl9KEKEaqD0TMuxpr1bvjYn+jd2ZD
         GXO+hgwoiu/JscS1elNst1/Spd9Bk8AM5TfdLxVtULObTWKiVHB1MRy3ZDLLuUEyE1qP
         Ge+Ds/4GKwPfI9wZa0IMWG2CiNzPxGq9eVG/92CbcLxKptUFuQw8mYM0RiiEmiCBKq8p
         6sMZ5Sq7TwE/QARE/BCVWC7/bxaz5MBSN6A14x07lRjabVcCc7ofyof/YAFWZYdStjhb
         JLu5oEc5qdNUGIbOiYeNGeEFDao01reJGTmX4rwK33qZgP8pBhpHLr5SvTWjMtLtqC6v
         UtAQ==
X-Gm-Message-State: AC+VfDzR6fhHtEdjEwXmYLpzynPYGtA2H/9EFgylsU5xbUHh+MX9aUpq
	y/cUkT9vO7F71TyYOOyK/TwVivPR8ZR9MApBRt/p8F++0w4=
X-Google-Smtp-Source: ACHHUZ6yDyUmm0tXzFMzzfomoP8D32NVEg93gEq8ytuKBtIZYBKn/U/185VAS0Kcm+kHDZq/0dkpZ9Kv/F0J5i/RVUk=
X-Received: by 2002:a17:903:41d2:b0:1ae:6947:e63b with SMTP id
 u18-20020a17090341d200b001ae6947e63bmr2807400ple.16.1685113396801; Fri, 26
 May 2023 08:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Nrg_PCVFR1UZLROME+TuKy5_3N=JgfBkLF2cpZaiaTVw@mail.gmail.com>
 <951f5c65-7648-ea55-6eed-feaa615bc7f5@gmail.com>
In-Reply-To: <951f5c65-7648-ea55-6eed-feaa615bc7f5@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 26 May 2023 10:03:05 -0500
Message-ID: <CAG17S_ObjJ8AJZtYwBuFgNO5pMU3_ufA_EOtUzDoQ11vcJXT2g@mail.gmail.com>
Subject: Re: wifi disconnects periodically
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> Its hard to say, there isn't much to go on here. I'd suggest running IWD
> in debug mode and seeing if we can get any more info from that.
>
> If your using IWD for DHCP you might also start IWD with
> IWD_DHCP_DEBUG=debug set in case its got something to do with a DHCP renew.
>
> Thanks,
> James
>
James,

I enabled debug 'iwd -d' and will see how it goes. If it happens
again, I'll hopefully have a log of it.
I enabled -d as opposed to the IWD_DHCP_DEBUG because I am using
connman to manage the interfaces. Isn't this correct that connman is
actually managing the DHCP?

Keith
