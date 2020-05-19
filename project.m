% code of group 17

%% declaration of variables
clc
average_stock_level=0;% variable to calculate the average stock level
expected_total_cost=0;% variable to calculate the expected total cost
end_invent=zeros(30,1);% stores the ending inventory
order_received=zeros(30,1);% stores the order received
open_invent=zeros(30,1);% stores the opening inventory
demand=zeros(30,1);% stores the current demand
c0=zeros(30,1);% stores the ordering cost each month
cs=zeros(30,1);% stores the shortage cost
ch=zeros(30,1);% stores the holding cost
lead_time=zeros(30,1);% stores the lead time
reorder=zeros(30,1);% stores the reordering
time=zeros(30,1);% stores the time in months
u=zeros(30,1);% stores the random number
flag=0;% checks whether the order is in progress or not
%%
open_invent(1,1)=0;
    k=0;
    prompt='enter the value of opening inventory at t=1 ';
    open_invent(1,1)=input(prompt);
    if(open_invent(1,1)<0)
          prompt='enter the value of opening inventory at t=1 ';
    open_invent(1,1)=input(prompt);
  
    end 
    prompt='enter the production cost(kp) ';
    kp=input(prompt);
    if(kp<0)
        
        prompt='enter the production cost(kp) ';
        kp=input(prompt);
    end    

     
    
%%    
    u(1,1)=floor(rand*100)/100;
    
    if(u(1,1)<0.01)
        demand(1,1)=0;
    elseif((u(1,1)>=0.01)&&(u(1,1)<0.07))
        demand(1,1)=1;
    elseif((u(1,1)>=0.07)&&(u(1,1)<0.32))
        demand(1,1)=2;
    elseif((u(1,1)>=0.32)&&(u(1,1)<0.67))
        demand(1,1)=3;
    elseif((u(1,1)>=0.67)&&(u(1,1)<0.87))
        demand(1,1)=4;
    elseif((u(1,1)>=0.87)&&(u(1,1)<0.90))
        demand(1,1)=5;
    elseif((u(1,1)>=0.90)&&(u(1,1)<1))
        demand(1,1)=6;
    end 
    
%%    
    end_invent(1,1)=open_invent(1,1)-demand(1,1);
    if(end_invent(1,1)<0)
       if(flag==1)
              %reordering not possible
           c0(1,1)=0;
           cs(1,1)=abs(end_invent(1,1))*70;
           ch(1,1)=0;
       
       else
           reorder(1,1)=abs(end_invent(1,1));
           flag=1;
           k=1+3;
           y=abs(end_invent(1,1));
           c0(1,1)=kp;
           cs(1,1)=abs(end_invent(1,1))*70;
           ch(1,1)=0;
           lead_time(1,1)=2;
       end   
        
    else    
        ch(1,1)=abs(end_invent(1,1))*30;
        c0(1,1)=0;
        cs(1,1)=0;
    end
 
  average_stock_level=end_invent(1,1);
  expected_total_cost=c0(1,1)+ch(1,1)+cs(1,1);
 time(1,1)=1;
  %%  
  for t=2:1:30
    if(t==k)
        order_received(t,1)=y;
        flag=0;
    else
        order_received(t,1)=0;
    end
    
        if(end_invent(t-1,1)<0)
            open_invent(t,1)=order_received(t,1);
        else
            open_invent(t,1)=end_invent(t-1,1)+order_received(t,1);
        end
   
  
%%    
    u(t,1)=floor(rand*100)/100;
    
    if(u(t,1)<0.01)
        demand(t,1)=0;
    elseif((u(t,1)>=0.01)&&(u(t,1)<0.07))
        demand(t,1)=1;
    elseif((u(t,1)>=0.07)&&(u(t,1)<0.32))
        demand(t,1)=2;
    elseif((u(t,1)>=0.32)&&(u(t,1)<0.67))
        demand(t,1)=3;
    elseif((u(t,1)>=0.67)&&(u(t,1)<0.87))
        demand(t,1)=4;
    elseif((u(t,1)>=0.87)&&(u(t,1)<0.90))
        demand(t,1)=5;
    elseif((u(t,1)>=0.90)&&(u(t,1)<1))
        demand(t,1)=6;
    end 
    
%%    
    end_invent(t,1)=open_invent(t,1)-demand(t,1);
    if(end_invent(t,1)<0)
       if(flag==1)
              %reordering not possible
           c0(t,1)=0;
           cs(t,1)=abs(end_invent(t,1))*70;
           ch(t,1)=0;
       
       else
           reorder(t,1)=abs(end_invent(t,1));
           flag=1;
           k=t+3;
           y=abs(end_invent(t,1));
           c0(t,1)=kp;
           cs(t,1)=abs(end_invent(t,1))*70;
           ch(t,1)=0;
           lead_time(t,1)=2;
       end   
        
    else    
        ch(t,1)=abs(end_invent(t,1))*30;
        c0(t,1)=0;
        cs(t,1)=0;
    end    
 average_stock_level=average_stock_level+end_invent(t,1);
 expected_total_cost=expected_total_cost+c0(t,1)+ch(t,1)+cs(t,1);
  
 time(t,1)=t;   
 
     
  end 
  
  
  
average_stock_level=average_stock_level/30;
expected_total_cost=expected_total_cost/30;
 
T=table(time,order_received,open_invent,u,demand,end_invent,reorder,lead_time,c0,ch,cs);
disp(T);
disp('average stock level is ');
disp(average_stock_level);
disp('expected total cost is ');
disp(expected_total_cost);

