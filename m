Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51236C
	for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 02:32:18 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1a682eee3baso26973965ad.0
        for <iwd@lists.linux.dev>; Sat, 22 Apr 2023 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682217138; x=1684809138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7mpJuMcND3RaDHKlYPMOAu0xbGUK1Mywgg0Jqo9YHk=;
        b=Qthksyzb++Grx+QCApfvQeOqECK1T1GOk0A0tDZWh0GHBtjeZbHst82TOQcBwrAqp7
         NM0/Yxio+ODhrR947s7A+jZMjsKRxr64/v3eD5fs7W5nCRS+the+9/QVxhPyjV3YT2Hb
         UPPErbMqro6si4yXcNPCmydnFO5z85PABv6gWodagS4HsI8yVrTPb0FKNCXeqhoNzY88
         Fe1DCxM9E1h3hmLMEocwJDM2WFiTFwaZQcKLrwRCaxO2/sqYYJwhWwVaKkmO+PpJDnyj
         ga10FviUZMIl0wi7Bo0uo4M9WS2g1WZJ5NlGiSVqcD2VrbbNB8mEKJ0Ia6LpddXXExJa
         UOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682217138; x=1684809138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7mpJuMcND3RaDHKlYPMOAu0xbGUK1Mywgg0Jqo9YHk=;
        b=L4mWl5m+GM16Cwxln6R4xiIjywfTjl39ChQX2GEkWpH6ULxrNqWKoE8wkgD+NxuRqZ
         Xe6gyhcSUAWHS+a5YsFgZimVzKIMHRl+6AgHcGcCLJ2xPmvKGrUv3dZaTEZf0AwpF8ck
         bEzAoySKV/NvsHCAVZnSjYZdlVP1GBuxtsJbCxPYLWmrlKXAsLgOkY0l/FMbJDXcXNLO
         gdM+gTeJ0G5twu0WYwpdqzfcv3YA+Me9+zDYTN+0mau6decp32vrJgUAHbZlSOmj+igt
         OZeD7z8OwrNVn8tKvmSVt3gY4dGl8BynuL7M/VtHDQU+e+Wl2xed3/SX7VgctyJVB7N/
         5a8g==
X-Gm-Message-State: AAQBX9eW3YyRu3nVfiZFdgEy4zIgWnvtgIZCSbGY5Q1pnWjk9gDMMbwH
	kQiHlEUW2JBHxPyiR/p0Yis=
X-Google-Smtp-Source: AKy350bGNQyGw9qfmPOcx9PTaQdJAfZPNDkxp9QdJI6PB3cyewqShmnftE+CfaPKv1HL+S+5qEdSLw==
X-Received: by 2002:a17:902:bd93:b0:1a6:e58f:8aee with SMTP id q19-20020a170902bd9300b001a6e58f8aeemr8664238pls.65.1682217138170;
        Sat, 22 Apr 2023 19:32:18 -0700 (PDT)
Received: from [192.168.254.37] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm4538034plk.168.2023.04.22.19.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 19:32:17 -0700 (PDT)
Message-ID: <537606f4-9708-0bad-2144-d4809dfd7548@gmail.com>
Date: Sat, 22 Apr 2023 19:32:13 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
To: Marcel Holtmann <marcel@holtmann.org>, daniel antoine <univac55@gmail.com>
Cc: iwd@lists.linux.dev
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <DE0B5BC4-B2D5-47FF-8D80-8FAEC8A65CA7@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 4/22/23 11:32 AM, Marcel Holtmann wrote:
> Hi Daniel,
> 
> changing the mailing list ;)
> 
>> I have tried to build iwd to the last commit "Allow building with
>> libedit instead readline". The Pkgfile seems to need the option
>> --enable-libedit to remove readline but it fails with
>>   CC       wired/dbus.o
>>   CCLD     ell/libell-internal.la
>>   CCLD     client/iwctl
>>   CCLD     src/iwd
>>   CCLD     wired/ead
>> /usr/bin/ld: client/command.o: in function `command_completion':
>> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
>> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to `rl_copy_text'
>> /usr/bin/ld: client/display.o: in function `save_input':
>> display.c:(.text+0x32): undefined reference to `rl_copy_text'
>> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to `rl_save_prompt'
>> /usr/bin/ld: display.c:(.text+0x46): undefined reference to `rl_replace_line'
>> /usr/bin/ld: client/display.o: in function `display_text':
>> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
>> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to `rl_replace_line'
>> /usr/bin/ld: client/display.o: in function `display_completion_matches':
>> display.c:(.text+0x834): undefined reference to `rl_copy_text'
>> /usr/bin/ld: client/display.o: in function `timeout_callback':
>> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
>> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to `rl_replace_line'
>> /usr/bin/ld: client/display.o: in function `display_table_footer':
>> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
>> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to `rl_replace_line'
>> /usr/bin/ld: client/display.o: in function `display_enable_cmd_prompt':
>> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
>> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
>> `rl_restore_prompt'
>> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
>> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
>> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to `rl_replace_line'
>> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
>> `rl_erase_empty_line'
>> /usr/bin/ld: client/display.o: in function `display_agent_prompt_release':
>> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
>> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
>> `rl_erase_empty_line'
>> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to `rl_replace_line'
>> /usr/bin/ld: client/display.o: in function `display_init':
>> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty_line'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [Makefile:1895: client/iwctl] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1595: all] Error 2
>> =======> ERROR: Building
>> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
>>
>> It looks like some readline commands are always taken in count
>>
>> I have my Pkgfile and the compilation log
> 
> It does build for me just fine. What distro is this?
> 
> What does pkg-config --cflags --libs libedit show?

I'm seeing the same build problem, Ubuntu 20.04:

$ pkg-config --cflags --libs libedit
-I/usr/include/editline -ledit

> 
> Regards
> 
> Marcel
> 
> 
