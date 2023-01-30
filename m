Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165A3C13
	for <iwd@lists.linux.dev>; Mon, 30 Jan 2023 16:13:49 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id bj22so1378785oib.11
        for <iwd@lists.linux.dev>; Mon, 30 Jan 2023 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+q7ING5kXejJYswn4uuAyM+99AfHsjkBLlAq5MoJPtg=;
        b=orn/RsjZ236AiDSlZ6Mt/JYM6/yP3zb/0VrkndJajCQCIPvEzPc+BClCZ573xjav3z
         lHmdGwQmOtRrxEGOZmZ8Br/DvFUdCFyRdY5s/dfki5sAccSL7RMnvdUf66CqmW9F8tt8
         I9c842/S0WjIxNioraRK78uo595S7zg3Lu9XxJH0CLsRhi3mB1Nxv9GxnGvaTIZ9BHY/
         9X4YPS9UyPjN4+PGapvld1i1JDNnZoJ4Mp7Nc+cN9/xNx2cmXya4XCwdQ55SEcMzU31j
         nNj3+RNHksFFhkZsIysf4vB4hYnMLmvtunK9GSLqtL26YaG61vFGbhaLEcm2ASApZ2ej
         RgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q7ING5kXejJYswn4uuAyM+99AfHsjkBLlAq5MoJPtg=;
        b=VjqPwlJmMX+DRP6sSh5Rsgadu/L23yflbYWIpZtmsXAITIt8ilBBp2FZqXL04uJa8m
         cWwytQzmcXnXixTScJ4arrb5REmPu9XyiQO108mN5lrLBbg6rYDrPVjqMiiY1OK4BtIn
         I3x8I3zPYTar+/TppR803y9YGMMnPG1/cNA4QLDWS13wI7kX9sTEpRfKAD4YGIYz+TTe
         BZ+sG3Em7DxYXecZPvv7YssVqd4I9OWhlM+PnYXSUfGMPNjlxEFw0zq32xbz34+RP5zX
         K60lCXs+inNKrdajkvHCFeH6LNwnQam34VM+UjJ30aS7RTvIwC94h4llUGsBC2kXEaud
         l1Mw==
X-Gm-Message-State: AFqh2koDN4NtTgZR6amcyr7/eQEitnIxo2v7dJoWkwaFVClWnubw7zKH
	5orCe/xdxjir8M16CMcxoT6DHybokhCqAg==
X-Google-Smtp-Source: AMrXdXu4HoQnHSfAzHql8NaXYbcY4Al+UeVFGoLxKGUUX8dN9x4EKhsXU86Q3ikVxUKN2nu8S2aX/g==
X-Received: by 2002:a54:4491:0:b0:363:ad47:34fc with SMTP id v17-20020a544491000000b00363ad4734fcmr24456971oiv.50.1675095228572;
        Mon, 30 Jan 2023 08:13:48 -0800 (PST)
Received: from [192.168.1.29] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 12-20020aca210c000000b0037874ef31a1sm384575oiz.51.2023.01.30.08.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:13:47 -0800 (PST)
Message-ID: <beb879cd-27ba-56eb-c30e-3cae23e9331f@gmail.com>
Date: Mon, 30 Jan 2023 10:13:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] eap-tls: Drop cached session when phase2 fails
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230127233323.3317642-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 1/27/23 17:33, Andrew Zaborowski wrote:
> If we have a TLS session cached from this attempt or a previous
> successful connection attempt but the overall EAP method fails, forget
> the session to improve the chances that authentication succeeds on the
> next attempt considering that some authenticators strangely allow
> resumption but can't handle it all the way to EAP method success.
> Logically the session resumption in the TLS layers on the server should
> be transparent to the EAP layers so I guess those may be failed
> attempts to further optimise phase 2 when the server thinks it can
> already trust the client.
> ---
>   src/eap-tls-common.c | 52 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

