Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF011FB3
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 16:01:56 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-101d96fe0a5so25857fac.2
        for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKJIxov0WHDvmBaT7t+YBlnRyPEZ248l/I6GxVd7uA8=;
        b=MZijR1YAMIUldkv1iDgLun/XoHhsGoTPYy0/UGkBk6XkJvrFA+Z2Rz3zoamE7IYdhQ
         r3pACle/qkkU+8tHVgF7isGigL2lBS6Wj2E6gfAhw6uRkgYtUW0NKy2W5SFOAd+2+mZt
         BOalVNtNp0idDxY66rofInpET6xq3goxn1c6Yzl4lh23gKf9I++naPotsZLs0SCM3KUA
         sW3siKeaWq2W2LQt7RReO877G18Rox944hEGYfPsbVmp5xyaNzXw3sg6qGTDk/wPj4Cg
         UULk0Fyr4bgSO3M85KzA1V8NuxJC/rSURjddjFEo8TSB2++8jLunquOFy0dzp4cx+5ai
         7Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKJIxov0WHDvmBaT7t+YBlnRyPEZ248l/I6GxVd7uA8=;
        b=UjEpNQO1j4d3P/C7VjgbRs4m3q9ShVXuBeMdfI66SokKlbPGxyVTgbQfu11UOyl9oa
         GN4lLVd/RZlrvQCBUMOzgc/McR6nG96iv0PcbRude8+h2m/XNIC2vmAf9xoC+sOmr5b1
         f77DkRjvpt0sn5DJROrR2z1t5lq9FHrT/HID9fP4NmCK5JAOPpVushP6Y8vW857wgsfG
         gsny8n8VYAIFpafOgwrxDoSfSnvfShlEvh7XxUFvExzhHPOUfX7aNXunO+g9zf7qyy8Z
         v2lKCBmRGIukrVlGiDMzdq1R0JrI8+RlJ84eKHV5IbXM1OyKxrCLo6z0I/TDmvQ9+LJe
         HRhQ==
X-Gm-Message-State: AJIora/N5jcedEYKm7MkRa8TELFwPXNYwzhquUesQkYgQLSkejUFKd36
	9DmjDbXMqyCBCOWTrwBJpTNA3HzILiM4T16cg90=
X-Google-Smtp-Source: AGRyM1sxUmdtpiIM9dE080KihBBRqcyIxf8BQRJrAEvUsfTjRHYxHrNFZOHsBk/tT7dKMKTc7Z96VkRuafaLXilpQr0=
X-Received: by 2002:a05:6870:968c:b0:102:6e3:7869 with SMTP id
 o12-20020a056870968c00b0010206e37869mr2933808oaq.98.1656000116125; Thu, 23
 Jun 2022 09:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACsRnHX4-Y93QsHz4W+gF7SkOV9u+snNiaDZv=8BOZ4Yz0YBcg@mail.gmail.com>
 <3a979ba0-f18f-12ec-6437-87c95ec1f9e8@gmail.com>
In-Reply-To: <3a979ba0-f18f-12ec-6437-87c95ec1f9e8@gmail.com>
From: Michael Johnson <mjohnson459@gmail.com>
Date: Thu, 23 Jun 2022 17:01:45 +0100
Message-ID: <CACsRnHVP7HeRTbzZHXM5p07rUqtL8La01RmLEUN4mHx3ttnbCQ@mail.gmail.com>
Subject: Re: Multiple IP addresses after failed roam
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

Thanks for looking, I appreciate it's a bit of a shot in the dark.

On Thu, 23 Jun 2022 at 16:25, Denis Kenzior <denkenz@gmail.com> wrote:
> That is actually very strange since during the failed roam we see this:
>
> Jun 22 13:26:33.016737 p3-6087 iwd[429]: src/resolve.c:resolve_systemd_revert()
> ifindex: 5
>
> Which implies that we are calling netconfig_reset().  This should result in the
> address being removed by netconfig_remove_v4_address().  I wonder if this
> removal fails somehow?  Might be worth adding a debug to see if
> netconfig->v4_address is somehow becoming NULL?

That is odd. Unfortunately I can't really add any new debug output due
to how the clients are deployed at the moment. So far I've only seen
this happen once after running with ~200 clients in a production-like
environment for a couple of days. I'll add some debug output to my
test environment but unless I can reproduce the issue I doubt I'll get
more information.

> > This was on version 1.21 + select patches applied (I didn't have time
> > to validate the latest version unfortunately).
>
> That version is getting a bit old and we did touch netconfig/station in some
> places since then.  But on the other hand, I can't recall anything that would
> directly affect what you're seeing here.

I am currently testing 1.28 so hopefully I can update to that soon :)

Regards,
Michael
