Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED59185B
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 16:58:01 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id cp25-20020a056830661900b00693ce5a2f3eso1442130otb.8
        for <iwd@lists.linux.dev>; Sun, 09 Apr 2023 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681059480; x=1683651480;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXYrAtK0FBSysnLvUWzSGoh53FDWYObl8pJWndGw5P4=;
        b=YfXG2891ULOm34mNXQ40Gn4fsT6R4RlToLJS7Mzqi7e7w8rCITfH52SHg7HHN5P4Yz
         e7Lxbpivecxha5TDrQ6+E00Qt4TZHc1qTQfdK2eU9ovHZh36g4/uwaDB5UiP8cJd4reV
         OEY/euyKK0GV1Wksg+aJmjWVYPuXFpy74sZNV1ZyOS4DUlC+1UjUwVCWGNcAh6hbYfLS
         mRevpQZC730VdNkPf4evDAmH6IfBt88Telee3zbv9x3AUH/XhzhyBPjpEloM33FAciYg
         0Y5RSx2apXqfFHtnZMBZ0lWJbJAGNWBL2ShLgdh6DzKutK0ppYWh+htCSJ1DErMHSPR1
         ZyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681059480; x=1683651480;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXYrAtK0FBSysnLvUWzSGoh53FDWYObl8pJWndGw5P4=;
        b=MY7jR7ruG+0ObZAIQidpgjzFOc52xNuDiVI5CkXUgpxzRlHMR6VzQWUr071U/ZrISB
         +o3kMCHJv/VxdtLPiQXD8y75ZjVetVqkNVnkO7yX382jY1lBdr9raWBT1jNjh5SdplAX
         oCy8/+GxTqq0WUinqZ9iePPwsVfS45a9llwCg3iFmmvC1C1koxjvaSnRbuEwOm5yI6lp
         sgXcmQUfSKRtIwavBNIYx09ggaPjfOXdUWgeT95eOpqFEbf26i+RSLp1fBkIo0L6XXv7
         sRdCKE622kMuaixiwI2E6mpiSj4Vf0wdkPCaVD0yWyFLmxlYCt+HzRExFcBxhpBgWVd0
         l5Sg==
X-Gm-Message-State: AAQBX9cEUqsTfAouAYqv6ye9TOqE7ErqcxPaFC4AJESwHxyF2U9XmYLn
	hyPH3E5u5JOGsg6XIa7FQ6efsy6MAh5LNA==
X-Google-Smtp-Source: AKy350alCk8kAAzBsk+Jigfvv7p/nYVEbL+WDxmh8PxX7P7o0wqKRzWdDgFbeL4cbjTStfzclDKCAA==
X-Received: by 2002:a05:6830:22fc:b0:693:d7bf:dc26 with SMTP id t28-20020a05683022fc00b00693d7bfdc26mr4431626otc.6.1681059480244;
        Sun, 09 Apr 2023 09:58:00 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c6-20020a9d67c6000000b006a143873c6bsm3519510otn.50.2023.04.09.09.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:57:59 -0700 (PDT)
Message-ID: <9fcce33b-22ad-bb56-d5d3-724450b709b6@gmail.com>
Date: Sun, 9 Apr 2023 11:47:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Initial choice of network should consider RSSI?
Content-Language: en-US
To: Cedric Sodhi <ManDay@openmail.cc>, iwd@lists.linux.dev
References: <ZDKinaeLzoAvaIb1@air>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZDKinaeLzoAvaIb1@air>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cedric,

On 4/9/23 06:33, Cedric Sodhi wrote:
> Hello,
> 
> I have a permanent problem with IWD when multiple known networks (different SSIDs) are in range: With a large probably (although it is most likely just random, depending on when the beacons fire) IWD manages to connect to a network with an unusable low RSSI while better networks are available.
> 
> I suspect there is currently no logic in place which would somehow work in favor of making a "good" choice? RoamThreshold, for example, doesn't seem to apply and InitialPeriodicScanInterval seems to have no effect either, given that the (initial) connection to the (bad) network happens immediately before InitialPeriodicScanInterval passed, and that choice does not seem to be revised even if the better network becomes visible within InitialPeriodicScanInterval.

Periodic scans are attempted every N seconds, with exponentially increasing N if 
no connectable network was found.  InitialPeriodicScanInterval simply sets the 
initial timeout N.  It isn't that iwd scans constantly during that period.

Once a periodic scan completes, and there's something to connect to, iwd 
attempts to do so.  If there are multiple somethings to connect to, then iwd 
prioritizes networks based on estimated throughput (this is where the RSSI is 
taken into account) and which network was most recently used.  There are some 
other factors.

> 
> Would it possible to either extend the meaning of InitialPeriodicScanInterval or introduce another option which would allow IWD to connect to a better, different SSID (thus not covered by roaming) within an initial period?
If you have a more concrete proposal please share it.  And patches are always 
welcome :)

Regards,
-Denis
