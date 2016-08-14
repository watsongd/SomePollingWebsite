var Stats = React.createClass({
  getInitialState: function() {
    setInterval(this.getUpdatedData, 10000);
    return {
      myPieChart: null,
      labels: this.props.labels,
      data: this.props.data,
      backgroundColors: this.props.backgroundColors,
      id: this.props.id
    }
  },
  getUpdatedData: function(e) {
    $.getJSON("/polls/" + this.state.id + "/stats/.json",
      function(json) {
        var newData = new Array();
        for (var key in json.options) {
          newData.push(json.options[key]);
        }
        this.setState({data: newData});
      }.bind(this)
    );
  },
  componentDidMount: function() {
    var ctx = document.getElementById("myChart").getContext("2d");
    var myPieChart = new Chart(ctx,{
        type: 'pie',
        data: {
          labels: this.state.labels,
          datasets: [
            {
              data: this.state.data,
              backgroundColor: this.state.backgroundColors
            }
          ]
        },
        options: {
          animation: false
        }
    });
  },
  render: function() {
    return(
      <div></div>
    )
  }
});