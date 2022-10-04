Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644C33D9
	for <iwd@lists.linux.dev>; Tue,  4 Oct 2022 17:45:27 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id t79so1702305oie.0
        for <iwd@lists.linux.dev>; Tue, 04 Oct 2022 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=daWoDMbixSQL1gBe7e8WUSV5XTQrY6h7vt/fpMnTaLA=;
        b=CmBxvvYtR4gv0REDlxN5fBLAfZ0y1S4uo11etl8iDcuhqtXsso3Gtum2K2BQ02Rrrv
         rfcXtRDY8+U3TNw/Q6qzq4loTAPTvXhTtMJXs4p87PkGv2xGMAo01Lo2cl7Plg0vFbCo
         ajKDOlQ0GNM6DfdugQ6oKADnB7S/+Oh9zGUWTZeyYNATXiLHm1hO9ORlIoVoPHse+nVU
         NvUY1JnyROkFhImChWD9oTF6LMijhoNq4F2ZLYXVRDZtf0VUor2RUNOOSrVkZMEfLH9P
         PYTQFNIrKFVVffYEah9RPj71n8AxKvqtJtPuI7WDtQGz2SyCYLiv39+NlwsA7m2MTJCZ
         8YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=daWoDMbixSQL1gBe7e8WUSV5XTQrY6h7vt/fpMnTaLA=;
        b=y8q4YzQEjIDsrYqWdRlW+IoqWp5299x3qmOO/cWH1N/vneSVF85m8LiAHJwjV6LkSK
         XzCxNXKtdUccoToS91shhT/D2bi/7rQ8sWBVBJDhJmVdrlYTHX8bWPnfV/oZ9EX0cReS
         AoJCEBcUSvC05khoROaNp+0Mu/RpzN68P31yUc+CrmExpA6QozbIXfsLg4J1XpR0gFy+
         yetN5gBSjuEd7w9wKnN/O+yKHXDjaw9GM1kLjS9tdNhJYdeQAOZoVuuyPkAHUmMC6XoN
         f9Y948/O/Ht9ztorAVplrHBnapvmBlll0ibJYF+3dhVTGj0W90xJlMWTDjpRuOMcAXYg
         I3Ng==
X-Gm-Message-State: ACrzQf1BaFazhNkwkftUkcYiSQVVJ9NkDOmT/lO7ctWphLQyohixZHWW
	QgzXwwjHC8iTuVBT/BLJbFkBNPI1mKo=
X-Google-Smtp-Source: AMsMyM4iQy3NhLH8DTpDNkQPA/+9VvDaYhGFob1fiwJutMYcq0c0hTM2a7JHcIZnSnRVPabvHCs+ig==
X-Received: by 2002:aca:2215:0:b0:350:37b4:c55 with SMTP id b21-20020aca2215000000b0035037b40c55mr420386oic.210.1664905527012;
        Tue, 04 Oct 2022 10:45:27 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n9-20020a4ac709000000b00425806a20f5sm2673887ooq.3.2022.10.04.10.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 10:45:26 -0700 (PDT)
Message-ID: <f6f552c0-bf23-7f75-62ef-86f73cd187d6@gmail.com>
Date: Tue, 4 Oct 2022 12:45:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] autotests: Add a stateless DHCPv6 test case
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220930144801.548229-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220930144801.548229-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 9/30/22 09:47, Andrew Zaborowski wrote:
> ---
>   autotests/testNetconfig/stateless_test.py | 162 ++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
>   create mode 100644 autotests/testNetconfig/stateless_test.py
> 

Applied, thanks.

Regards,
-Denis

