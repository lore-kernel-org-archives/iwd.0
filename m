Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7033D6
	for <iwd@lists.linux.dev>; Tue, 28 Jun 2022 22:51:53 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id h65so19199358oia.11
        for <iwd@lists.linux.dev>; Tue, 28 Jun 2022 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FqpHz+n3Jn+VZMXcYuZ8ohbvVlNn06qeU4WYry323sc=;
        b=MfKFGXSO5fOQFtxGSZ73M+a6jePKdvLxaROq/TlbGdYmhgoUdEpSHRIY6etrVvoMDV
         uawF1Jk1/gIVr3gjAH92vhA5IFZ8mxET/QTevwuOUT/iKCEx+ezqfJzaVzSvfIXD8VtP
         ZkKw1LHBd7Z0rYyhMrE3p1FBcRPP7v1Dk54cD+nGoPlYiTUA+HNdIfEstoTk61lvlvKx
         tZIR2jyFjXJufOeIXnAmHBIeakayX9IhN7C98fH6rUsAfzI+MIiP9pAAEVzGPIHW2Gj1
         WW9g/dJi5T/4mVScOA1T0klK/a0espSz/dd7Js92K9edjt9UyqF0GQES/3eL9pavBrG9
         zthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FqpHz+n3Jn+VZMXcYuZ8ohbvVlNn06qeU4WYry323sc=;
        b=3jQdS7X27y+xgNQmJiyrn2uhnslkblLt5WbebsUYMQe3gdv+j2wzdKnCcb3viGqRxV
         hamysmI4ln14QejTY3MXB/wGi5I2erTWOOBIAAAaqvIjSISlWEw5dXIhLwkdIq1paXva
         6N/pKmvGVdq6I8EfWSZSjWzpQ9LACG+4K99sN7IvptqWpYakPsLT1kfntpiBR8BuoqlA
         2cl3Yv7DM6Q2jF9T8UQdRpBDgrHbCzHdrFZaAJYovZ7pB7l3PXJy3UufQZg+YuanJra6
         AAwfkcs4r4ElaZqRI3TJyw/CeSdOBTCq8JdZnug/trc6ASjnKF6m7gPZhWGOME/CZsHs
         7dbw==
X-Gm-Message-State: AJIora/F11BnrjQkLqev7iWOIWUeUpVmVtFl9HbFwNyqxZ+yqYdnjF2G
	cz0aJM+gBSdGaRJ7i0649fs=
X-Google-Smtp-Source: AGRyM1uhwaA+Cg9WI4ZGVFP7wwgl7XTNisQJTj68dsqFSN70jkL76oC8StL4vWAcFFZdUJMpZEze3g==
X-Received: by 2002:a05:6808:ec1:b0:331:4236:242c with SMTP id q1-20020a0568080ec100b003314236242cmr227256oiv.19.1656456713052;
        Tue, 28 Jun 2022 15:51:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x27-20020a9d459b000000b0060c0c6e9186sm3869214ote.15.2022.06.28.15.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 15:51:52 -0700 (PDT)
Message-ID: <ddab39a7-9ef4-a9be-d453-f884b8933d76@gmail.com>
Date: Tue, 28 Jun 2022 17:49:35 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] client: fix crash from unknown properties
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220628215739.2332211-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220628215739.2332211-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/28/22 16:57, James Prestwood wrote:
> The dbus proxy code assumes that every interface has a set of
> properties registered in a 'proxy_interface_property' structure,
> assuming the interface has any properties at all. If the interface
> is assumed to have no properties (and no property table) but
> actually does, the property table lookup fails but is assumed to
> have succeeded and causes a crash.
> 
> This caused iwctl to crash after some properties were added to DPP
> since the DPP interface previously had no properties.
> 
> Now, check that the property table was valid before accessing it. This
> should allow properties to be added to new interfaces without crashing
> older versions of iwctl.
> ---
>   client/dbus-proxy.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

