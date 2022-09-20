Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38947462
	for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 15:24:41 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso4723382fac.4
        for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EsAALlxLuarhNCn6Jrr0i1o2UmAi2XKfySzlCpxwHlA=;
        b=BlRu8aH0T4yCsoda7RkQ+S9TIqW7o2IVeu2G59XCm7/3IliHj+poCgrGiwmMyBgx+H
         JqOwM19tPZsLRFVmgolRrdKWPXr3fPYDYKbeV5hNGehQemUW4avxoZvkMoK4JgiYVOc/
         jmL9mLuCSKUrNYsrMNcM5yuTtQgziKHVN8tn/JhGRh9k4F3RaZ4vsqzHelHj4xAFdDEy
         lC+T3Sx1h/vGXqLYv63rXnSGTmgXxVh2j9pzPl2xi0n2ndcjZfe0hwCtSMb769BNgJDs
         RgWfCPVXiywC6ohWbM4e7/Ts88ELgFYrA50l2O6wgM6rQ/iftCigRshY0Zd2CKON3b7h
         grkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EsAALlxLuarhNCn6Jrr0i1o2UmAi2XKfySzlCpxwHlA=;
        b=JW8ejpiEj6We5juj4Y+km5tajd/fvXyhz3Pw1/oXjiRPj5mQjnXpT7N4SwLZHsuZgs
         TwLbwW+y7O8vZkUKqmZ0HEWYPgmyFgCIwce27+E4100nKsTYXXpLVfDtHFDiWgocWthW
         /+vZ/AHoZs/zZTT0EL+TyEvKGmX9MUom+MI/Vl0FODxTUa8omU81Ml7bLPGxOqfFJueR
         On+nFSUhT5aIXuzY7KBhe3NTN/yLcH8u9qm8Qs81+nzGw2cTJeY+Zpgx/vSYtsal2O7m
         fZwX9K9UM5U5anEqMGvXy2qx0GcZbyD0CbYgNDgOHZkGOuHXCveC9nLXUVI1c+UHN1N8
         UIpA==
X-Gm-Message-State: ACrzQf384N+MEhtWHCdUAA1t4MSHpGQJi4GT/RQ4jc5eWFwWP9QjFRn8
	HiQZOyhjRIwhgh4Brj8mEHrJUXAkZlY=
X-Google-Smtp-Source: AMsMyM6htuL1K802xZEzAeEHOeldRtlgT7sAbk95ANWGHNQ94mn3bNuDg0BByG6iUnp8J0q9BwWnCw==
X-Received: by 2002:a05:6870:4711:b0:12c:82d2:bca2 with SMTP id b17-20020a056870471100b0012c82d2bca2mr2343362oaq.153.1663687480779;
        Tue, 20 Sep 2022 08:24:40 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t10-20020a4ac88a000000b0044b125e5dabsm5588ooq.35.2022.09.20.08.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:24:40 -0700 (PDT)
Message-ID: <1fa74849-feb2-3d42-8bc1-e4699cc6c881@gmail.com>
Date: Tue, 20 Sep 2022 10:07:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] netconfig: Drop D-Bus path from debug message
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 9/20/22 09:05, Andrew Zaborowski wrote:
> l_dbus_message_get_path(reply) is normally NULL in this callback so
> don't bother printing it.
> ---
>   src/netconfig-commit.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

