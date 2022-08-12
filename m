Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED39138C
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 15:10:08 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id u14so1456993oie.2
        for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cpLeLFb9DxIezkBsYWtMuwUgmfl8F9mdICSmoCW9ZZA=;
        b=E40VriEFuo/Vg/JxKSmEX4H38CEe5fIMJ2n89XD5ifOhl/Xek0GgwoMlL+Iciyh7g3
         l6xdf9cwi7FD7GTp92qSrOfHxDyj4puTezKDcKLjNlAtqzmmBeuAZFBGUKLc7oVWob3b
         ezXhRUbxUircJgfa5xQwe8YXJqnJ9qhdLJcxNB9ePxv6svKw4vqVnfdQQ09xd6PC9SnZ
         D5z/e6HQTW7tgrobEGZ0dpF9rUDJoU0Q9GPtCYuEic/KExOm5qrBgT986reZzYfdWd0l
         u0hzd7VsFTy3WfR0DuOEiMcW5oTvUHIb88l9xAoKpnvfFav0K7SVCoRN31ygi2snDZR1
         wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cpLeLFb9DxIezkBsYWtMuwUgmfl8F9mdICSmoCW9ZZA=;
        b=OEOLqSHvcQ6IPu22QzNTKthlcReO0cYeSTgemr8cmvruXyhnxL0nA0C8rvtTehZoEH
         X2FBAU6KplJZoZ0aoyLeUgEvGYutD7ywDtZ7ttJDukfzaa9e7f9ankuXiivi64IsxlC9
         BN2VMbk7c504AumXnQsvejiq6z42SJk0ERg3UnqfpBAvu+7i1IQ74u7yv/LwT39tPYB0
         y99bPQAkEkacplIU78lwcZUHyGLgJIxkBJ6+0+PD6cjS3Wr6Xcx3e0+pAywzA3Laow4y
         YhvE9Kr3GiqdQsJuC1l2UVKIxeq8btOMxjZarkh6+dsyMDmajdZLigs55TKOVYqwZifE
         YBwg==
X-Gm-Message-State: ACgBeo0Y1kYWhOhwSyowWluxoptCkJ2Zm1wGfDiWxTUhrvZ6o0qXCQtJ
	Db4gJQPhyIiMuUVrJJWWAOaOMXfzHmU=
X-Google-Smtp-Source: AA6agR6yDdxAjVijOSjivW9f0ftyxUcRaxcrc39f7vCKD+p8H9nmhtTh5r5kePebu+iwSuLzjEZeHg==
X-Received: by 2002:a05:6808:1687:b0:32c:3e3e:89b1 with SMTP id bb7-20020a056808168700b0032c3e3e89b1mr1964871oib.60.1660317007774;
        Fri, 12 Aug 2022 08:10:07 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z23-20020a056870461700b0010bf07976c9sm358207oao.41.2022.08.12.08.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 08:10:07 -0700 (PDT)
Message-ID: <47479f89-c065-8402-818b-d0becc285c27@gmail.com>
Date: Fri, 12 Aug 2022 10:01:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd needs restart after suspending
Content-Language: en-US
To: Joachim Breitner <mail@joachim-breitner.de>, iwd@lists.linux.dev
References: <f79517c3f23c14dcd6db0dd5f3fb48fdeb687315.camel@joachim-breitner.de>
 <fa74ccdf82f2f4db651d50e51583bd85eca3fb28.camel@joachim-breitner.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <fa74ccdf82f2f4db651d50e51583bd85eca3fb28.camel@joachim-breitner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joachim,

> I recorded the output of iwd -d on 5.15 and 5.19, see attachement. The
> relevant bit seems to be
> 

We should add this to our debug output, but what driver / hardware are you using?

> src/station.c:station_enter_state() Old State: connected, new state: disconnected
> src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 is XX
> src/scan.c:scan_notify() Scan notification Trigger Scan(33)
> src/netconfig.c:netconfig_ifaddr_deleted() ifaddr 192.168.178.39/24
> src/scan.c:scan_request_triggered() Active scan triggered for wdev 6
> src/station.c:station_quick_scan_triggered() Quick scan triggered for wlan0
> src/scan.c:scan_notify() Scan notification New Scan Results(34)
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> src/scan.c:get_scan_callback() get_scan_callback
> src/scan.c:scan_parse_bss_information_elements() Load: 31/255
> src/scan.c:get_scan_callback() get_scan_callback
> src/scan.c:get_scan_callback() get_scan_callback
> 
>                             

So with 5.15, the underlying netdev is disconnected.  We get notified of that 
and start scanning.

> with 5.15 and
> 
> src/station.c:station_enter_state() Old State: connected, new state:
> disconnected
> src/station.c:station_enter_state() Old State: disconnected, new state:
> autoconnect_quick
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3

Here, we receive what looks to be an IFDOWN event.

> src/station.c:station_free()
> src/netconfig.c:netconfig_destroy()
> src/scan.c:scan_cancel() Trying to cancel scan id 3 for wdev 3
> src/scan.c:scan_cancel() Scan is already started
> src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> src/station.c:station_roam_state_clear() 3
> src/rrm.c:rrm_station_watch_destroy()
> 

So the question is why is the kernel changing this behavior?  iwd is not aware 
of resume/suspend, so I'm not sure we can tell whether the ifdown event came 
from the user manually bringing down the device or due to suspend / resume.

What does rfkill look like on 5.15 & 5.19 after resume?

Regards,
-Denis
