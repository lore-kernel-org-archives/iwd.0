Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90A4A00
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 19:42:05 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id w70so3226540oie.2
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW9VpJn1yNiyX1Ys3kKJTkpWtV1y+rhSuE4PzqGr1Xw=;
        b=LF6c7DtQ3Tlirx9un4qv2lStuE6Z7xwPOmhQwsJkHJQVAGfF9MDTHYC78wtJBngaJ+
         JBKzwSxdeL9fr/qzhTQcidTYteHmtUkxaU4nypmL0IONWUYPZtSsRlz5vUyY9jvM0HXT
         AbnIkDVGSD2t8fm9FgakLngemWJ3JvkXLOH6QwSt8ByLBiJq/wyf07/HN3T8vVtuOyrM
         woxNZa+DIgkpjuIM5ESerXXajqfZrbePMtoVkfu0Ps63jinM8Bnk89B5foDOEcFftg5B
         Mly/QMeM7nZSVUUGulgvCiZrIsoVpFsSN+WBONO110oWdITgM51N4YvNdQ3njAGgUSGJ
         zG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wW9VpJn1yNiyX1Ys3kKJTkpWtV1y+rhSuE4PzqGr1Xw=;
        b=Um+iemY32h4F+pnj/Puv7BVQTFtZPnf5g8avGE+lEMpwLw33nrqu85w3GvTlTPqSkF
         2FAY7+GuVUlO0vSYTv44slp+cHBuQcZ2mMq6VjtxhJkVBNLdKxnroa8tVavW8aMLT+mc
         fgbuxzdue3CIq98UXE2gBkgzF1+vn8TnwPBaH7Elm6zAarn0VegjqSyk1Gmn/9UfM72Q
         270ptzzzfG92yQlfYOnSjacKggbhqIBxrP/iJl0MYQ8q4n//Mdct8Sqk5V2iNZwy4VKg
         tv6KxArh3FNE7hE3xRZbdVU3K9giiHQcpEvvoR5dWDA0XRpdGu2GcECvpZmOIfY/SrjR
         IStQ==
X-Gm-Message-State: ACrzQf3R64yu/xeoZHUYravjrILGYE6Gp8huFfofk3vMRTVvLLc1u70x
	VTmi/iVt8X9WqLnLiahEjIY=
X-Google-Smtp-Source: AMsMyM72TGVlzAHszyICd17/YsUGpCt9ixki0ARzvMl9lOld8lg/gI+0MroTHcpbYyeVYAE5tjp/eg==
X-Received: by 2002:a05:6808:308e:b0:354:ee5:1d21 with SMTP id bl14-20020a056808308e00b003540ee51d21mr2377964oib.31.1665085324936;
        Thu, 06 Oct 2022 12:42:04 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n126-20020acabd84000000b003512f3195d7sm22146oif.30.2022.10.06.12.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:42:04 -0700 (PDT)
Message-ID: <e793d41a-1209-b4da-67ab-db6010f422ee@gmail.com>
Date: Thu, 6 Oct 2022 14:42:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] auto-t: speed up testHiddenNetworks
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221006174040.823577-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221006174040.823577-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/6/22 12:40, James Prestwood wrote:
> The CI was sometimes taking ~10-15 minutes to run just this
> test. This is likely due to the test having 7 radios and
> which is a lot of beacons/probes to process.
> 
> Disabling the unused hostapd instances drops the runtime down
> to about 1 minute.
> ---
>   .../connect_after_hidden_connect_test.py          | 12 +++++++++++-
>   autotests/testHiddenNetworks/exceptions_test.py   | 11 +++++++++++
>   autotests/testHiddenNetworks/open_network_test.py | 14 ++++++++++++++
>   autotests/testHiddenNetworks/wpa_network_test.py  | 15 +++++++++++++++
>   4 files changed, 51 insertions(+), 1 deletion(-)

Both applied, thanks.

Regards,
-Denis

