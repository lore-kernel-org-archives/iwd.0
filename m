Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9A2EAE9
	for <iwd@lists.linux.dev>; Fri, 22 Dec 2023 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiEtRmE8"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7fdde8b98so94051139f.1
        for <iwd@lists.linux.dev>; Fri, 22 Dec 2023 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703282971; x=1703887771; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sBeCE40HdSKMdI6sNJTAhLebeD6UalgNBVB/BJfd7s=;
        b=QiEtRmE82yTxG9IYwo9OkKfrB0eun7BqnOrf7ShOzgsXuJYSfP0N0gjnlJ4TkZpA+p
         aXc//6f08J5mUmRSvJ7LSD8c7+jSOSzsNyas0/oCNEvHLXNRcfKegiGOEInq9/B23xsR
         8NChcRhJM2s3tOBD0PNe3S7Fz4g65Cmjk3QGvNq086oloXpqsOl2JoI8rbO/KJVFsdM0
         plXe5mb/4R8UgSlRqSm7DItkay5J4WktzL3jwGk2PVeAMqNSSbBlW1x3RvtMlhOFzYrO
         PFPzDzBE8/Ac9+QyPm308NZwxFU5BSVZNDbcht7gQFTduPxd4OGaeIio5LAAQZi7wTgA
         2Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703282971; x=1703887771;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sBeCE40HdSKMdI6sNJTAhLebeD6UalgNBVB/BJfd7s=;
        b=W53oLsE50kHAGcRo5uMMT+c4CSSLlvER8T/A3xYkLf32D7BtROYURFkNhXC9mRUUm9
         elDqjqnFt0iKJ/uTfW0BNw10W133b/vaOlvscMjBiTGmrfsquJVV/GRuepvzobGqynAP
         m/wd4t1W12+2ulcYNqeJYwba6Cl/7Fyy6TxaIfkxyQC4IzGueu/iyl4s1k/VUY2WOe7q
         R9lLimqzGsRP6/NJg66AK1S8cncJR8A12laVOWtqwbEyRKO8y09yz6rsza2e31GU3JHN
         VPd0NLXEgT/0eeEkTfM2tTYs9orm4LtURgFIJYuvu4tlN+uLfGyAFiCmrRWI78EYIKmO
         xzLw==
X-Gm-Message-State: AOJu0YzE8XhoQnX1JL+4sMbg3L+GdDSq88ofEY1DofmZJEqelkIoMTEA
	6qPDNKmYz8THgF9Y+FKhXk4=
X-Google-Smtp-Source: AGHT+IHBU39Br71Y/U3vkUgD3y4P4RGcCJACpmlU6FNd1b5cSTMqDbq1WGQ254BEeTRzNtMHWb7Dcg==
X-Received: by 2002:a05:6602:158f:b0:7b7:c981:1002 with SMTP id e15-20020a056602158f00b007b7c9811002mr3193697iow.19.1703282970850;
        Fri, 22 Dec 2023 14:09:30 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id k7-20020a6b6f07000000b007b0684e260dsm1197259ioc.2.2023.12.22.14.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 14:09:30 -0800 (PST)
Message-ID: <e6df3b9c-25ae-4bc1-96b5-cf8211d69b10@gmail.com>
Date: Fri, 22 Dec 2023 16:09:29 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] known_network: rename known_network_add_frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231220131200.267489-1-prestwoj@gmail.com>
 <20231220131200.267489-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231220131200.267489-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/23 07:11, James Prestwood wrote:
> Rename to known_network_add_seen_frequency. This prepares to
> differentiate between tracking frequencies based on a BSS being
> seen versus being connected to. When a BSS has been connected to
> that frequency should be preferred when roaming/quick scanning.

Okay, you assert this, but can you elaborate on how you came to this conclusion? 
  I would think that adding a BSS you have seen recently in scan results should 
be preferred over one you might have connected to days earlier but haven't seen 
since.

Regards,
-Denis
