Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97712B64
	for <iwd@lists.linux.dev>; Thu, 29 Jun 2023 14:51:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fba545d743so8488705e9.0
        for <iwd@lists.linux.dev>; Thu, 29 Jun 2023 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688050308; x=1690642308;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWmOv1veAO5kxWkDVZ6jWmtNy8QKKsIqDTSl61pcFA8=;
        b=LoGROq9Z5f+zO1c7APxIxGkwgoAP6uknawLPImEMDbggsqQ1uIN1mdP9huDY6N2oP8
         /NmPdHQ+VLeSnAqxJ11Xb08zrD7NvULGJtZ/C3amiYnu5S8MAsxH4u7bGHOLOYT6fsFj
         9e57KYP/JjiYp0BNbEP+ZKvV+boPLUmpZfcKM97WV8YMokk4ncDhYdJWzDKJ12ao15AW
         i/5dT4Y67rV23q/jfsmGZAAJVK1Ge95fUI8LjaDWITl6a6hpdigH8vGHJC6ukvWUqXkg
         NAbFHzJIB1X3HJbb5vZIxieCrsEw2DvmUNR++1MLPfxskX0laoAG0VgVCOaCQyrs0a9s
         xySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050308; x=1690642308;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWmOv1veAO5kxWkDVZ6jWmtNy8QKKsIqDTSl61pcFA8=;
        b=MTMgQktnxWEaNeGzQUfzLkEXsblEzNPuonvqN0K/p9ws2oXUU+psSsYXqy1rj0QCl9
         Xm/Gm1FdMrw7cdyYLknW5NQMqMi9TvmLU0d0TngFR3iKNXPsL2xZALzpAbkBdgyxK73m
         JoZvQ7pOueYX99F0/MQUK5SiVE/CQYxU/Y/xPZF/CVh9JIg4ukQbYAbbxKbdMAe4KHxK
         e9+JvYchiLriZmN2Q8pcJmUb4QOLGoHkBmq0MYlTqCigNu2d8FJ2W58HZpI4OhUpIqw4
         pPsO3W70lp8PJuosOvRo1GWyWrBovgIZbt+um+yHMAsrm+l2MzQ3QMa3l2rWlrV6MBLb
         4HTg==
X-Gm-Message-State: AC+VfDymDHoWbdzGK/I2XNWQvfMaHF2MCbuNwgSl9+ioYamlyA8kzJVy
	/G33t2RJCy90636QjZS1xbc=
X-Google-Smtp-Source: ACHHUZ6f/3972/16tLwTEj9vCZGlngz2QTti+3bxDp/3x5PeSF1zAPH5F0MSgSksOI12enOGWNpVYA==
X-Received: by 2002:a7b:c399:0:b0:3fa:95c7:e891 with SMTP id s25-20020a7bc399000000b003fa95c7e891mr10569055wmj.35.1688050308064;
        Thu, 29 Jun 2023 07:51:48 -0700 (PDT)
Received: from [10.123.13.239] ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe303000000b0030fd03e3d25sm16064723wrj.75.2023.06.29.07.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:51:47 -0700 (PDT)
Message-ID: <3dbd7478-78cd-6851-c5ed-c652ad43002d@gmail.com>
Date: Thu, 29 Jun 2023 07:51:44 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: IWD network state directory
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
References: <0a6ebf72-8cbd-21a1-eade-b2aea4aab572@tavla.de>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0a6ebf72-8cbd-21a1-eade-b2aea4aab572@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 6/29/23 12:51 AM, Martin Petzold wrote:
> I find it very uncomfortable that I cannot change the IWD network state 
> directory using symlinks (most probably because of the monitoring or 
> integration with systemd) or parameter at "iwd" startup. In general, 
> there is no option documented to set this directory. In the 
> documentation I only find "the configuration directory specified by the 
> environment variable $CONFIGURATION_DIRECTORY, which is normally 
> provided by systemd" [1]. However, systemd restricts the 
> "StateDirectory=" to paths below "/var/lib/" by definition [2]. I am not 
> sure how I would be safe to overwrite this environment variable still 
> using systemd.
> 
> Because I need to move the state to a separate partition I was using 
> bind mounts, with maybe some issues (still not sure about the actual 
> cause). Now switching from bind mounts via systemd service to fstab. 
> Maybe related to something specific with systemd (see my earlier post).
> 
> [1] https://man.archlinux.org/man/iwd.config.5.en
> [2] https://www.freedesktop.org/software/systemd/man/systemd.exec.html

This is really a gripe with systemd. IWD doesn't care what 
STATE_DIRECTORY is used but systemd is what puts strict limitations on 
that directory.

You could configure IWD to use a different directory:

./configure --localstatedir=<dir>

Then unset StateDirectory in the service:

StateDirectory=

The localstatedir is the prefix, and the actual dir is under 
<localstatedir>/lib/iwd. But you could then make this a symlink. Its a 
round-about way of doing it, but it works.

Thanks,
James

> 
> 
> 
