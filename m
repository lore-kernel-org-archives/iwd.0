Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A90746F
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 22:11:42 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id l8-20020a056830054800b006705fd35eceso8208874otb.12
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQBfnbzakIeh66TmU37heZGMZ00PQ+GJwqcnaqS01Jg=;
        b=agtRaYycTgwojrzJ68UBC/KBb2LTbZBbsvzyEic0lLfygonwkKqrKhWDDNeqs+pFHb
         FSDRWmfXDIxot4CGkVQASqnkdkJFhkIR/Dz8ZeJ/3aReCTkuT1N9D7HJM4C/ugkv4OiA
         oQKEV9dYYUICZtEzojnaIWYtdX13jsk2ZQnNS+R1pzcqpFSlkrFMduIwAnJIM8ut65kh
         OHftU9ru5vVTog9CIHrpE+e/sugvmln66AB2RSgrRRVfECI5HXn3Xz3MAs1fgrW7/d6O
         hmXAF2w0g67OgV21ZLoEfDLhPMaCmCWaRUuwZr6U6UOl7lO+GGKPPaobc+9N3bjqg0IT
         MLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQBfnbzakIeh66TmU37heZGMZ00PQ+GJwqcnaqS01Jg=;
        b=TycbKRlcmJ7+xtnYO7wb7tR8c6Louost1/YQlN7k5+cOIgQ9AqfZ7Y4MwDAxdkObzy
         8GNXEY9LE/SicURiKSb4tQuzSnKWJdRXdTo3ftadgoSPBs+/wCh9qiI6FFsYnLJKt8ZJ
         nIf6TAElj9HO6Blv75cVYbytYtHmUGx4kJUF8OhtrnCOs36MhdOJ7jr2PRor4V/DMaDU
         wSYtBp0HbPcb8cQ+6JstT3mut6+gaQl9LjBqfQ1dct0/ssM9dWkzKjIadZc74m0IHrR4
         RkIlYQutCsH6L3NLb8WpgSY2Se8EqfG1EL2wlS8nWMQFxp9gnx46z3ozUYClNuCUz49O
         1pBA==
X-Gm-Message-State: ANoB5plpDC9YsCEB4lDpk7qLHXdnENoq+m0UGxR3ir299d71EWsABrGK
	+b+eoa9gx8fTIcv+p7IoMrw=
X-Google-Smtp-Source: AA0mqf6ZUOwWktgG66swEwthjt8jgEOSYGXKvunncAeFKz+3d6U7TKQwrsawBkjFtOzQ/IpqMuY99w==
X-Received: by 2002:a05:6830:6481:b0:66d:aba2:a8f0 with SMTP id ck1-20020a056830648100b0066daba2a8f0mr11825438otb.10.1670883102111;
        Mon, 12 Dec 2022 14:11:42 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v21-20020a9d7d15000000b0066c3bbe927esm461078otn.21.2022.12.12.14.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:11:41 -0800 (PST)
Message-ID: <0bd53fcf-7367-46de-0567-e4e0fa8cca09@gmail.com>
Date: Mon, 12 Dec 2022 16:00:21 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd release 1.30 onwards cannot find available networks
Content-Language: en-US
To: Bruno Dantas <dantas@airpost.net>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bruno,

On 12/12/22 13:27, Bruno Dantas wrote:
> Hi, Denis.
> 
>> And can you elaborate what 'hangs' mean?  If there are no networks, then you should see a "No networks available" print or something similar.
> 
> By "hangs" I mean that when I run "station wlan0 scan", the command never returns. I work in a hospital office where there are _many_ wifi networks within range, including ones with strong signal.

Gotcha.  Having a hang in 'station wlan0 scan' makes sense since it is an async 
method.  The get-networks method is synchronous so it shouldn't ever 'hang'.

Please try

[PATCH] scan: remove early supported check for 6ghz in wiphy watch

that James just sent and see if it fixes your issue.

Regards,
-Denis
