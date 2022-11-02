Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07A7461
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 19:59:36 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12c8312131fso21501430fac.4
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4u/TlA//isrN+000X7Ucl6Aua/yF0mn25GwBXdIu3w=;
        b=nSe0PfZ2jj46W3YMQ4phSSnWitMRtJK8YSDGMEJlHk+Krw8Ca+BMT1ZHaxyjA0DIXi
         bet1OdN+D6502/U0h4H5SO0m9lN7egKbDGlfCPGyYkPHISHDKZteqYiNd4744pKzlo3e
         vrCTkGs3h9D2AP1YRs5k/Ptdr60lKy3L6WrVTAfhZEzWw1Ejkgac+bhv+DezbFVKPjdu
         FGGHFfnNilBk6XkyaxzQbBm6X3TSmDvX+1+3ymxlso1f6z4ZGzGg6F/o+bBgr3YpcivT
         EJH56MyuIxKStmetJLa6s4wG+MtJu+CYdfFFHC4xtwlrqetbXXjD154boVNPhqIGfRce
         nYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4u/TlA//isrN+000X7Ucl6Aua/yF0mn25GwBXdIu3w=;
        b=hqD5GK/W7X9ziGomPP5I8ycIhqAl/2ztF3oD76PSb7Y6efyarxgMXCPFu9LIGOTe/h
         8VwgNCpXvKXvW5BclrfdleDIhRu/mQTuMX+Cr4/1z8aQfPB77MV4sbeXRsqBks5gzoSH
         CxmXqPFjgu0eM50wNl8dKzRPU8Tz5PiLDGzOocppuwsKXgK4ArwLlVMDACzJ5RibNeNe
         V+0oonaDpkKHf/i6AFUOvj/jwJKYo1iQpUToUOPqL457qr2O6aMiLmlq/YpzQyo0yt/s
         xpRN62oTRHDYKAAwc+R9HNH3jorX90xnRcQ1/pHxQVt7YedF1OEPHXATUrPXYzzDdJDX
         sgJQ==
X-Gm-Message-State: ACrzQf19VPVCgnhCYNmQx3XE0/AL5UHJKFPAli0XtctMwgYHvfDF/qOq
	xohPGZBcqguAtv6gKGej/AtQN12YOR8=
X-Google-Smtp-Source: AMsMyM7Xaz/Vst/xO9u4iTFyvcfqxcC75riVI98vNhyMJbiZtZGF3dgrqIOLzddey1+5E/brpw7wyQ==
X-Received: by 2002:a05:6870:15d0:b0:13c:2aa5:d967 with SMTP id k16-20020a05687015d000b0013c2aa5d967mr15720747oad.143.1667419175919;
        Wed, 02 Nov 2022 12:59:35 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t3-20020a9d5903000000b0066c4ff0e5b5sm3945666oth.48.2022.11.02.12.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:59:35 -0700 (PDT)
Message-ID: <ffc95d8d-78c5-7baf-c5be-0ed35e36895e@gmail.com>
Date: Wed, 2 Nov 2022 14:59:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] client: fix spurious newlines in station show
Content-Language: en-US
To: eNV25 <env252525@gmail.com>, iwd@lists.linux.dev
References: <20221102092156.71357-1-env252525@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221102092156.71357-1-env252525@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/2/22 04:21, eNV25 wrote:
> This change removes duplicated calls to display_table_footer(), in
> station show.
> 
> Before this change, the bug caused an extra newline to be output every
> time the table updated. This only occurred when the network was
> disconnected.
> 
>      $ iwctl
>      [iwd]# station wlan0 show
> 
> ---
>   client/station.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 


Can I get a proper full name please?  I can't take this into the repo otherwise.

Regards,
-Denis
